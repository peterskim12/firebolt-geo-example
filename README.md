# Firebolt Geo Example

This repository contains example data files and scripts for working with geographic data in Firebolt.

## Data Files

The `/data` directory contains the following files:

- `philadelphia-neighborhoods.jsonlines`: Geographic data of Philadelphia neighborhoods in JSONL (JSON Lines) format, containing features with properties like neighborhood names, lengths, and areas along with their geometric boundaries. This was downloaded from [OpenDataPhilly](https://opendataphilly.org/datasets/philadelphia-neighborhoods/).
- `philadelphia-neighborhoods.csv`: A CSV version of the neighborhoods data, containing the properties from the JSONL file. This file was generated using the conversion script described below.
- `indego-trips-2025-q2.csv`: Bike sharing trip data from Philadelphia's Indego system for Q2 2025. This was downloaded from the [Indego website](https://www.rideindego.com/about/data/).

## Scripts

### jsonlines_to_csv.py

This Python script converts JSONL (JSON Lines) formatted files to CSV format. It was specifically used to convert the Philadelphia neighborhoods data from JSONL to CSV format.

Usage:
```bash
# Basic usage (output will match input filename with .csv extension)
python jsonlines_to_csv.py data/philadelphia-neighborhoods.jsonlines

# Or specify a custom output file
python jsonlines_to_csv.py data/philadelphia-neighborhoods.jsonlines output.csv
```

The script:
- Takes an input JSONL file and optional output CSV file as command-line arguments
- Automatically determines the columns based on the properties in the JSONL data
- Converts each JSONL feature's properties into CSV rows
- Handles JSON parsing errors gracefully

For the Philadelphia neighborhoods data, the script extracts these properties:
- NAME: Neighborhood name
- LISTNAME: Alternative listing name
- MAPNAME: Name used for mapping
- Shape_Leng: Shape length
- Shape_Area: Shape area

### sql_scripts.sql

SQL scripts written for Firebolt to demonstrate geospatial query capabilities.

---

Disclosure: This README file was initially generated using VS Code's AI agent and then updated by a human with additional detail.

The jsonlines_to_csv.py script was initially generated using VS Code's AI agent and then modified by a human.