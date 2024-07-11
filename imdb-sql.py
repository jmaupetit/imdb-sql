#!/usr/bin/env python

import sys
from pathlib import Path

import pandas as pd
from rich.console import Console
from rich.markdown import Markdown
from sqlalchemy import create_engine

console = Console()

# Configurations
database_url = "sqlite:///im.db"
chunksize = 1000

# Command line arguments
if len(sys.argv) > 1:
    database_url = sys.argv[1]

# Database connection
console.log(f"Database URL: [cyan]{database_url}")
db_engine = create_engine(database_url, echo=False)

# Datasets to import
datasets = list(Path(".").glob("**/*.tsv.gz"))
console.log(f"Datasets found: {[d.name for d in datasets]}")


def basename(filename: Path) -> Path:
    """Remove all suffixes from a Path."""
    if {".gz", ".tsv"} & set(filename.suffixes):
        filename = basename(filename.with_suffix(""))
    return filename


for dataset in datasets:
    # Get dataset base name for the table name
    table = basename(dataset).name

    # CSV to dataframe
    console.log(f"Loading dataset: {dataset.name}")
    df = pd.read_csv(dataset, sep="\t", na_values=r"\N")
    index_col = ({"nconst", "tconst", "titleId"} & set(df.columns)).pop()
    df.set_index(index_col, inplace=True)
    console.log(
        f"Dataset loaded. Index is [cyan]{index_col}[cyan]. It contains {df.size} rows."
    )

    # Preview
    console.rule("Data preview")
    console.print(Markdown(df.sample(5).to_markdown()))
    console.rule("End preview")

    # Dataframe to SQL
    console.log(
        f"Writing to database: [cyan]{database_url}[/cyan] table: [cyan]{table}[/cyan]"
    )
    wrote = df.to_sql(
        name=table, con=db_engine, chunksize=chunksize, if_exists="replace"
    )
    console.log(f"Wrote {wrote} lines")
