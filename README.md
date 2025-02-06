# data quality framework with dbt and DuckDB

## Overview
This project uses **dbt (Data Build Tool)** to test data stored in **DuckDB**.

## Project Structure
```
/dbt_project
│-- models/             # dbt models (SQL transformations)
│-- macros/             # Custom macros for reusable SQL logic
│-- tests/              # Custom and generic tests
│-- seeds/              # Static data files (CSV)
│-- snapshots/          # Historical data snapshots
│-- dbt_project.yml     # Project configuration
│-- profiles.yml        # Connection settings for DuckDB
│-- README.md           # Project documentation
```

## Installation & Setup
### Prerequisites
- Python (>= 3.11)
- dbt (>= 1.6)
- DuckDB (installed as a package)

### Installation Steps
1. Install dbt and DuckDB:
   ```sh
   pip install dbt-core dbt-duckdb duckdb
   ```
2. Set up a `profiles.yml` file to configure the DuckDB connection.
   ```yaml
   duckdb_project:
     outputs:
       dev:
         type: duckdb
         path: 'data/compnay_database.duckdb'
     target: dev
   ```
3. Verify the connection:
   ```sh
   dbt debug
   ```

## Running dbt Commands

- **Test data quality:**
  ```sh
  dbt test
  dbt test --select source:company_database.quote        

  ```

## Defining Tests for Sources
This project includes only  **source tests** to validate incoming data. Tests are defined in `.yml` files under `models/`


## Custom Tests
Custom tests are stored in the `tests/` and  `macros/` directories and can be reused across 


