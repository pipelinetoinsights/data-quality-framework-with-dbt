# data quality framework with dbt and DuckDB

## Overview
This project uses **dbt (Data Build Tool)** to test data stored in **DuckDB**. The project is containerized using Docker for consistent development and deployment environments.

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
│-- Dockerfile          # Docker configuration
│-- docker-compose.yml  # Docker compose configuration
│-- requirements.txt    # Python dependencies
│-- README.md           # Project documentation
```

## Installation & Setup

### Option 1: Docker Setup (Recommended)
1. Ensure Docker and Docker Compose are installed on your system
2. Build and run the container:
   ```sh
   docker-compose build
   docker-compose up
   ```
3. Run dbt commands inside the container:
   ```sh
   docker-compose run dbt run
   docker-compose run dbt test
   ```

### Option 2: Local Setup
#### Prerequisites
- Python (>= 3.11)
- dbt (>= 1.6)
- DuckDB (installed as a package)

#### Installation Steps
1. Install dbt and DuckDB:
   ```sh
   pip install -r requirements.txt
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

### Using Docker
```sh
# Run all models
docker-compose run dbt run

# Run tests
docker-compose run dbt test

# Run specific tests
docker-compose run dbt test --select source:company_database.quote

# Generate documentation
docker-compose run dbt docs generate
```

### Using Local Setup
```sh
# Test data quality
dbt test
dbt test --select source:company_database.quote
```

## Docker Configuration

### Environment Variables
The following environment variables can be set in your `docker-compose.yml`:
- `DBT_PROFILES_DIR`: Directory containing profiles.yml
- `TZ`: Timezone setting (default: UTC)

### Volume Mounts
- Project files are mounted at `/usr/app/dbt`
- dbt profiles are mounted from `~/.dbt`
- Data files are mounted from the local `data/` directory

## Defining Tests for Sources
This project includes only **source tests** to validate incoming data. Tests are defined in `.yml` files under `models/`

## Custom Tests
Custom tests are stored in the `tests/` and `macros/` directories and can be reused across the project.




