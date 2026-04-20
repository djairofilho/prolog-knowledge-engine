from __future__ import annotations

import ast
from pathlib import Path
from typing import Iterable

import pandas as pd


ROOT_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = ROOT_DIR / "data" / "raw"
PROCESSED_DIR = ROOT_DIR / "data" / "processed"

PREFERRED_RAW_FILE = RAW_DIR / "games_march2025_cleaned.csv"
FALLBACK_RAW_FILE = RAW_DIR / "games.csv"
OUTPUT_FILE = PROCESSED_DIR / "games_clean.csv"

MIN_REVIEWS = 50

SOURCE_COLUMNS = [
    "appid",
    "name",
    "release_date",
    "price",
    "windows",
    "mac",
    "linux",
    "publishers",
    "genres",
    "pct_pos_total",
    "num_reviews_total",
    "positive",
    "negative",
]


def source_file() -> Path:
    if PREFERRED_RAW_FILE.exists():
        return PREFERRED_RAW_FILE
    return FALLBACK_RAW_FILE


def parse_list(value: object) -> list[str]:
    if pd.isna(value):
        return []

    text = str(value).strip()
    if not text:
        return []

    try:
        parsed = ast.literal_eval(text)
    except (ValueError, SyntaxError):
        return [text]

    if isinstance(parsed, list):
        return [str(item).strip() for item in parsed if str(item).strip()]

    return [str(parsed).strip()] if str(parsed).strip() else []


def first_or_unknown(values: Iterable[str]) -> str:
    return next(iter(values), "desconhecido")


def clean_category(value: object) -> str:
    text = str(value).strip()
    if text.lower() in {"", "nan", "none", "na", "n/a"}:
        return "desconhecido"
    return text


def detect_platforms(row: pd.Series) -> str:
    platforms = []
    if bool(row.get("windows")):
        platforms.append("windows")
    if bool(row.get("mac")):
        platforms.append("mac")
    if bool(row.get("linux")):
        platforms.append("linux")
    return ";".join(platforms) if platforms else "desconhecida"


def main() -> None:
    input_file = source_file()
    if not input_file.exists() or input_file.stat().st_size == 0:
        raise FileNotFoundError(
            f"Nenhum CSV bruto encontrado. Coloque o dataset em {PREFERRED_RAW_FILE}."
        )

    df = pd.read_csv(input_file, usecols=SOURCE_COLUMNS)

    cleaned = pd.DataFrame()
    cleaned["game_id"] = "app_" + df["appid"].astype(str)
    cleaned["nome"] = df["name"].astype(str).str.strip()
    cleaned["genero"] = df["genres"].apply(
        lambda value: clean_category(first_or_unknown(parse_list(value)))
    )
    cleaned["preco"] = pd.to_numeric(df["price"], errors="coerce").fillna(0).round(2)

    rating = pd.to_numeric(df["pct_pos_total"], errors="coerce")
    positive = pd.to_numeric(df["positive"], errors="coerce").fillna(0)
    negative = pd.to_numeric(df["negative"], errors="coerce").fillna(0)
    total_reviews_from_votes = positive + negative
    fallback_rating = (positive / total_reviews_from_votes * 100).where(
        total_reviews_from_votes > 0
    )
    cleaned["avaliacao"] = rating.fillna(fallback_rating).fillna(0).round().astype(int)

    release_date = pd.to_datetime(df["release_date"], errors="coerce")
    cleaned["ano"] = release_date.dt.year
    cleaned["plataformas"] = df.apply(detect_platforms, axis=1)
    cleaned["publisher"] = df["publishers"].apply(
        lambda value: clean_category(first_or_unknown(parse_list(value)))
    )

    review_count = pd.to_numeric(df["num_reviews_total"], errors="coerce")
    cleaned["popularidade"] = review_count.fillna(total_reviews_from_votes).fillna(0).astype(int)

    cleaned = cleaned[
        (cleaned["nome"] != "")
        & (cleaned["nome"].str.lower() != "nan")
        & cleaned["ano"].notna()
        & (cleaned["genero"] != "desconhecido")
        & (cleaned["popularidade"] >= MIN_REVIEWS)
    ].copy()

    cleaned["ano"] = cleaned["ano"].astype(int)
    cleaned = cleaned.sort_values(
        by=["popularidade", "avaliacao"], ascending=[False, False]
    )

    PROCESSED_DIR.mkdir(parents=True, exist_ok=True)
    cleaned.to_csv(OUTPUT_FILE, index=False, encoding="utf-8")

    print(f"Fonte: {input_file}")
    print(f"Registros tratados: {len(cleaned)}")
    print(f"Arquivo gerado: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
