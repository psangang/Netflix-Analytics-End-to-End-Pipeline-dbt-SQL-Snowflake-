🚀 Project Overview

This project demonstrates a complete end-to-end modern data pipeline using the Netflix dataset. It showcases how raw JSON/CSV data is transformed into clean, analytics-ready fact and dimension tables using dbt, Snowflake, and best practices inspired by modern data engineering.

The goal of this project is to replicate how real companies structure their data pipelines — following modular SQL, semantic modeling, data quality testing, and automated transformations.

🌐 High-Level Architecture

           ┌─────────────────────────┐
           │     Raw Netflix Data     │
           │   (CSV / JSON files)     │
           └───────────┬─────────────┘
                       │
                       ▼
           ┌─────────────────────────┐
           │     Snowflake (RAW)      │
           │  Loaded via Snowflake UI │
           └───────────┬─────────────┘
                       │
                       ▼
        ┌───────────────────────────────┐
        │             dbt                │
        │  - Staging Models (STG)        │
        │  - Intermediate Models (INT)   │
        │  - Fact & Dim Tables (MARTS)   │
        │  - Generic & Custom Tests       │
        │  - Documentation & Lineage      │
        └───────────┬───────────────────┘
                    │
                    ▼
     ┌────────────────────────────────────┐
     │      Analytics-Ready Dataset        │
     │  (Fact tables, dim tables, KPIs)    │
     └────────────────────────────────────┘

     📁 Project Structure


    dbt-on-netflix-snowflake/
│
├── models/
│   ├── staging/
│   ├── intermediate/
│   ├── marts/
│   ├── tests/
│
├── macros/
│
├── seeds/
│
├── snapshots/
│
└── dbt_project.yml

Each folder represents a clean layer in the analytics workflow — similar to Medallion Architecture (Bronze → Silver → Gold).

⸻

🔍 Detailed Project Walkthrough

1. Raw Data Loading
	•	Netflix data is uploaded into Snowflake (RAW schema).
	•	Source tables are registered using sources.yml.

⸻

2. Staging Layer (STG)

Purpose:
	•	Clean raw data
	•	Standardize column names
	•	Fix datatypes
	•	Remove duplicates

Example:
select
    id,
    title,
    type,
    release_year,
    trim(description) as description
from {{ source('raw', 'netflix_titles') }}

3. Intermediate Layer (INT)

Purpose:
	•	Apply business rules
	•	Joins across datasets
	•	Add calculated fields

⸻

4. Marts Layer (FACT & DIM)

Purpose:
	•	Final analytics-ready tables
	•	Fact tables for metrics
	•	Dimension tables for reporting

⸻

5. Data Quality Tests

Includes:
	•	Generic tests (unique, not_null, accepted_values)
	•	Custom tests (e.g., check nulls across all columns)

Example:
tests:
  - unique:
      column_name: id
  - not_null:
      column_name: title

      6. Documentation & Lineage
	•	Run dbt docs generate
	•	View with dbt docs serve
	•	Interactive lineage graph is created automatically

⸻

🛠️ How to Run This Project

1. Clone Repo
git clone https://github.com/psangang/Netflix-Analytics-End-to-End-Pipeline-dbt-SQL-Snowflake-.git
cd dbt-on-netflix-snowflake

2. Install dbt
Mac:
brew update
brew install dbt-snowflake

3. Set Up Your profiles.yml
Example Snowflake config:
netflix_dbt:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <account>
      user: <user>
      password: <pwd>
      role: transform
      warehouse: compute_wh
      database: netflix
      schema: analytics
      threads: 4

4. Run Models
    dbt run

5. Run Tests
    dbt test

6. View Documentation
    dbt docs generate
    dbt docs serve

🎯 What This Project Demonstrates

✔ Ability to build end-to-end pipelines
✔ Strong SQL transformation skills
✔ dbt best practices (staging → marts, modular modeling)
✔ Snowflake cloud data warehousing
✔ Implementing data quality and lineage
✔ Industry-level analytics engineering patterns

⸻

🧠 Learning Roadmap (If You’re New)

Step 1 — Learn dbt Fundamentals
	•	Models
	•	Sources
	•	Tests
	•	Documentation
	•	Jinja macros

Step 2 — Learn Snowflake Basics
	•	Warehouses
	•	Databases & schemas
	•	Virtual compute
	•	SQL features

Step 3 — Build More End-to-End Projects



