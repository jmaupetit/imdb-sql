#!/usr/bin/env python

import pandas as pd
from rich.console import Console
from rich.markdown import Markdown
from sqlalchemy import create_engine

console = Console()

# Configurations
database_url = "sqlite:///im.db"
titles_filename = "title.basics.tsv.gz"

# Database connection
db_engine = create_engine(database_url, echo=False)

# CSV to dataframe
console.log(f"Loading title file: {titles_filename}")
titles = pd.read_csv(titles_filename, sep="\t", na_values=r"\N", index_col="tconst")
console.log(f"Title file loaded. It contains {titles.size} rows.")

console.rule("Titles preview")
console.print(Markdown(titles.sample(5).to_markdown()))
console.rule("End preview")

# Dataframe to SQL
console.log(f"Writing titles to database: {database_url}")
wrote_titles = titles.to_sql(name="title", con=db_engine, chunksize=1000)
console.log(f"Wrote {wrote_titles} titles")
