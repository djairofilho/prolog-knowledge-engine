from __future__ import annotations

import re
import unicodedata
from pathlib import Path

import pandas as pd


ROOT_DIR = Path(__file__).resolve().parents[1]
INPUT_FILE = ROOT_DIR / "data" / "processed" / "games_clean.csv"
OUTPUT_FILE = ROOT_DIR / "prolog" / "generated" / "base_conhecimento.pl"


def normalize_atom(value: object, prefix: str = "x") -> str:
    text = str(value).strip().lower()
    text = unicodedata.normalize("NFKD", text)
    text = "".join(char for char in text if not unicodedata.combining(char))
    text = re.sub(r"[^a-z0-9_]+", "_", text)
    text = re.sub(r"_+", "_", text).strip("_")

    if not text:
        text = "desconhecido"

    if text[0].isdigit():
        text = f"{prefix}_{text}"

    return text


def prolog_string(value: object) -> str:
    text = str(value).replace("\\", "\\\\").replace("'", "\\'")
    return f"'{text}'"


def write_fact(lines: list[str], predicate: str, *args: object) -> None:
    rendered_args = ", ".join(str(arg) for arg in args)
    lines.append(f"{predicate}({rendered_args}).")


def main() -> None:
    if not INPUT_FILE.exists() or INPUT_FILE.stat().st_size == 0:
        raise FileNotFoundError(
            f"CSV tratado nao encontrado. Execute primeiro: python etl/clean_dataset.py"
        )

    df = pd.read_csv(INPUT_FILE, keep_default_na=False)

    lines = [
        "% Base de conhecimento gerada automaticamente.",
        "% Nao edite este arquivo manualmente; use etl/generate_prolog.py.",
        "",
    ]

    for row in df.itertuples(index=False):
        jogo = normalize_atom(row.game_id, prefix="app")
        genero = normalize_atom(row.genero)
        publisher = normalize_atom(row.publisher)

        write_fact(lines, "nome", jogo, prolog_string(row.nome))
        write_fact(lines, "genero", jogo, genero)
        write_fact(lines, "preco", jogo, round(float(row.preco), 2))
        write_fact(lines, "avaliacao", jogo, int(row.avaliacao))
        write_fact(lines, "ano", jogo, int(row.ano))

        for plataforma in str(row.plataformas).split(";"):
            write_fact(lines, "plataforma", jogo, normalize_atom(plataforma))

        write_fact(lines, "publisher", jogo, publisher)
        write_fact(lines, "popularidade", jogo, int(row.popularidade))
        lines.append("")

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_FILE.write_text("\n".join(lines), encoding="utf-8")

    print(f"Jogos exportados: {len(df)}")
    print(f"Arquivo gerado: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
