from __future__ import annotations

from pathlib import Path

import kagglehub


ROOT_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = ROOT_DIR / "data" / "raw"

DATASET_HANDLE = "artermiloff/steam-games-dataset"
DATASET_FILE = "games_march2025_cleaned.csv"


def main() -> None:
    RAW_DIR.mkdir(parents=True, exist_ok=True)

    downloaded_path = kagglehub.dataset_download(
        DATASET_HANDLE,
        path=DATASET_FILE,
        output_dir=str(RAW_DIR),
    )

    print(f"Dataset baixado: {downloaded_path}")


if __name__ == "__main__":
    main()
