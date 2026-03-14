
**1. High-Level Architecture Type**

Your project follows a Modern Analytics Engineering Architecture using dbt.Specifically, it implements a Layered Data Modeling Architecture that separates raw data ingestion from business-ready analytics.

**The system consists of three major layers:**

Data Ingestion Layer
Staging Transformation Layer
Dimensional Modeling Layer
Analytical Mart Layer

This architecture mirrors what many companies use in modern data warehouses.

Layer Overview
Layer	Purpose
Data Ingestion	Loads raw CSV data into the warehouse
Staging Layer	Cleans and standardizes raw data
Dimensional Layer	Builds stable business entities
Mart Layer	Creates aggregated insights for reporting

This separation ensures clean data governance and maintainable transformations.

**2. Project Directory Architecture**

Your structure:

nyc_taxi_production/
│
├── macros/
│   └── clean_strings.sql
│
├── models/
│   ├── staging/
│   │   └── nyc_taxi/
│   │       ├── _sources.yml
│   │       ├── _stg_models.yml
│   │       └── stg_taxi_zones.sql
│   │
│   └── marts/
│       ├── core/
│       │   ├── _core_models.yml
│       │   └── dim_taxi_zones.sql
│       │
│       └── marketing/
│           ├── _marketing_models.yml
│           └── mart_borough_zone_counts.sql
│
├── seeds/
│   └── taxi_zone_lookup.csv
│
├── tests/
│
├── dbt_project.yml
├── README.md
└── .env



The project separates:

Reusable logic
source ingestion
transformations
analytics marts
tests
documentation

**3. Data Ingestion Layer**

seeds/
seeds/taxi_zone_lookup.csv

In dbt, seeds are used to load static datasets into the data warehouse.
The ingestion workflow is:

CSV File
     │
     ▼
dbt seed
     │
     ▼
PostgreSQL Table

This converts the raw CSV into a database table.

Example resulting table:
taxi_zone_lookup

Columns might include:

LocationID
Borough
Zone
service_zone

The seed file becomes the raw data source for transformations.

**4. Source Definition Layer**

_sources.yml

This file defines the raw data source inside dbt.

Example concept:

sources:
  - name: taxi_data
    tables:
      - name: taxi_zone_lookup

This enables the use of the source() function.

**5. Staging Layer (Data Standardization)**

stg_taxi_zones.sql
This model acts as the data cleaning layer.

Responsibilities:

Rename columns
Clean text
Standardize casing
Fix formatting issues
Cast correct data types


**6. Macro Layer (Reusable Logic)**

clean_strings.sql

Macros in dbt allow you to create reusable SQL logic.

• Removes whitespace
• Standardizes capitalization

Example transformation:

"MANHATTAN " → Manhattan
"brooklyn" → Brooklyn

**7. Dimensional Modeling Layer**

dim_taxi_zones.sql

This model represents a dimension table.

Dimension tables store descriptive attributes used in analytics.

Example structure:

dim_taxi_zones
-----------------------
location_id
borough
zone
service_zone

Purpose:

• Provide stable business entities
• Support analytical queries
• Improve warehouse organization

This layer represents the canonical business dataset.

**8. Analytical Mart Layer**

mart_borough_zone_counts.sql

This layer produces aggregated business insights.


**9. Testing Strategy**

Your project implements data quality validation.

Two types of tests are applied.
Schema Tests
Defined in .yml files.
Example:

tests:
  - not_null
  - unique

Applied to:

location_id

This ensures:

Test	Purpose
Not Null	Prevent missing keys
Unique	Prevent duplicates
Fail-Fast Testing

Tests are applied early in the pipeline.

Workflow:

Source Data
     │
     ▼
Tests
     │
     ▼
Staging
     │
     ▼
Dimensional Models

If bad data appears:

**10. Environment Configuration**

Credentials are stored using environment variables.

Example:

DBT_HOST
DBT_USER
DBT_PASS
DBT_DBNAME

Referenced in dbt using:

{{ env_var('DBT_USER') }}


**11. dbt Project Configuration**

dbt_project.yml

This file controls the entire project.

Responsibilities:

• Define model paths
• Configure seed behavior
• Set schema targets
• Control materializations

Example:

models:
  nyc_taxi_production:
    staging:
      materialized: view
    marts:
      materialized: table

Meaning:

Layer	Materialization
Staging	Views
Marts	Tables

**12. Pipeline Workflow**

Your full pipeline operates like this:

CSV Dataset
     │
     ▼
dbt seed
     │
     ▼
Source Definition
     │
     ▼
Staging Transformations
     │
     ▼
Dimensional Model
     │
     ▼
Analytical Mart
     │
     ▼
BI Dashboard / Reporting

This pipeline transforms raw data into analytics-ready insights.




