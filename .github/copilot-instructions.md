# testdbt - dbt Data Transformation Project

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

This is a dbt (data build tool) project for building reliable data transformation pipelines. The repository contains Python-based analytics engineering workflows using SQL and YAML configurations.

## Working Effectively

### Environment Setup
- Bootstrap the environment:
  - `python3 -m venv .venv`
  - `source .venv/bin/activate`
  - `pip install --upgrade pip`
  - `pip install dbt-core dbt-duckdb` -- takes 2-3 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
  - `pip install sqlfluff pre-commit black ruff` -- takes 2-3 minutes. NEVER CANCEL. Set timeout to 10+ minutes.

### dbt Project Setup
- Initialize a new dbt project:
  - `dbt init --skip-profile-setup project_name`
- Configure database connection:
  - Create `~/.dbt/profiles.yml` with database credentials
  - For local development, use DuckDB: `type: duckdb, path: "project.duckdb"`
- Test configuration:
  - `dbt debug` -- validates setup and connection

### Building and Running
- Parse and validate project:
  - `dbt parse` -- validates SQL and YAML syntax. Takes 5-10 seconds. NEVER CANCEL.
- Build models:
  - `dbt run` -- executes all models. Takes 10-60 seconds depending on project size. NEVER CANCEL. Set timeout to 5+ minutes.
  - `dbt run --select model_name` -- run specific model
- Test data quality:
  - `dbt test` -- runs all tests. Takes 10-30 seconds. NEVER CANCEL. Set timeout to 5+ minutes.
- Generate documentation:
  - `dbt docs generate` -- creates project documentation. Takes 5-15 seconds. NEVER CANCEL.
  - `dbt docs serve` -- serves docs locally (requires manual stopping)

### Validation and Linting
- Always lint SQL before committing:
  - `sqlfluff lint models/ --dialect duckdb` -- SQL linting. Takes 10-30 seconds. NEVER CANCEL.
  - `sqlfluff fix models/ --dialect duckdb` -- auto-fix SQL issues
- Validate Python code (if any):
  - `ruff check` -- Python linting
  - `black .` -- Python formatting
- Run full validation workflow:
  - `dbt parse && dbt run && dbt test` -- complete validation pipeline. Takes 30-120 seconds. NEVER CANCEL. Set timeout to 10+ minutes.

## Validation Scenarios

Always manually validate changes by running through these complete workflows:

### Basic dbt Workflow
1. Parse project: `dbt parse`
2. Run models: `dbt run`
3. Test data: `dbt test`
4. Generate docs: `dbt docs generate`

### Development Workflow
1. Create or modify SQL models in `models/` directory
2. Add tests in `models/schema.yml` files
3. Run validation: `dbt parse && dbt run --select model_name && dbt test --select model_name`
4. Lint SQL: `sqlfluff lint models/model_name.sql --dialect duckdb`
5. Run full test suite: `dbt run && dbt test`

### End-to-End Validation
After any changes:
1. `source .venv/bin/activate`
2. `dbt debug` -- verify configuration
3. `dbt run` -- build all models
4. `dbt test` -- run all tests
5. `sqlfluff lint models/ --dialect duckdb` -- validate SQL style
6. Verify documentation generates: `dbt docs generate`

## Common Tasks

### Repository Structure
```
.
├── .venv/              # Python virtual environment
├── .github/            # GitHub workflows and configurations
├── .gitignore          # Git ignore rules (Python-focused)
├── README.md           # Project documentation
└── dbt_project/        # dbt project directory (created via dbt init)
    ├── models/         # SQL model files
    ├── tests/          # Custom test files
    ├── macros/         # Reusable SQL macros
    ├── seeds/          # CSV files for reference data
    ├── snapshots/      # SCD Type 2 snapshots
    ├── analyses/       # Ad-hoc analysis queries
    └── dbt_project.yml # Project configuration
```

### Key File Locations
- dbt configuration: `~/.dbt/profiles.yml`
- Project config: `dbt_project.yml`
- Model definitions: `models/**/*.sql`
- Test definitions: `models/**/schema.yml`
- Documentation: `target/` (generated)

### Database Adapters
- **DuckDB** (recommended for development): `pip install dbt-duckdb`
- **PostgreSQL**: `pip install dbt-postgres`
- **Snowflake**: `pip install dbt-snowflake`
- **BigQuery**: `pip install dbt-bigquery`

### Common Commands Reference
```bash
# Environment
source .venv/bin/activate

# Project lifecycle
dbt init project_name
dbt debug
dbt deps                    # Install packages
dbt seed                    # Load CSV seeds
dbt run                     # Build models
dbt test                    # Run tests
dbt docs generate           # Generate documentation

# Development
dbt run --select model_name
dbt test --select model_name
dbt compile                 # Compile without running
dbt clean                   # Clean target directory

# Validation
sqlfluff lint models/ --dialect duckdb
sqlfluff fix models/ --dialect duckdb
ruff check                  # Python linting
black .                     # Python formatting
```

### Expected Timing
- Virtual environment creation: 10-20 seconds
- Package installation (dbt + tools): 3-5 minutes total
- Project initialization: 5-10 seconds
- Model parsing: 5-10 seconds
- Model execution: 10 seconds to 5 minutes (depends on complexity)
- Test execution: 10-60 seconds
- Documentation generation: 5-15 seconds
- SQL linting: 10-30 seconds

### Troubleshooting
- **Connection issues**: Check `~/.dbt/profiles.yml` configuration with `dbt debug`
- **SQL compilation errors**: Run `dbt parse` to validate syntax
- **Model dependencies**: Use `dbt deps` to install required packages
- **Performance issues**: Use `dbt run --select model_name` to test individual models
- **Test failures**: Review test definitions in `schema.yml` files

## Critical Notes
- **NEVER CANCEL** build or test commands - they may take several minutes
- Always use **NEVER CANCEL** with timeout values of 10+ minutes for pip installs
- Always activate virtual environment before running dbt commands
- Always run `dbt parse` before committing to validate syntax
- Use DuckDB adapter for local development (no additional setup required)
- SQL files use Jinja templating - test compilation with `dbt compile`
- Model materializations (table, view, incremental) affect build time significantly