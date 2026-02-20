# Terraform Snowflake Module - Dynamic Table

![Release](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table/actions/workflows/ci.yaml/badge.svg)&nbsp;![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?logo=snowflake&logoColor=white)&nbsp;![Commit Activity](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Last Commit](https://img.shields.io/github/last-commit/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Release Date](https://img.shields.io/github/release-date/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Repo Size](https://img.shields.io/github/repo-size/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![File Count](https://img.shields.io/github/directory-file-count/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Issues](https://img.shields.io/github/issues/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Top Language](https://img.shields.io/github/languages/top/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table)&nbsp;![Custom Endpoint](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/80f87398675390e505575bcb8a748852/raw/terraform-snowflake-dynamic-table.json?)

A Terraform module for creating and managing multiple Snowflake dynamic tables using a map of configuration objects.

## Features

- Map-based configuration for creating multiple dynamic tables
- Built-in input validation with descriptive error messages
- Sensible defaults for optional properties
- Outputs keyed by dynamic table identifier for easy reference
- Support for configurable target lag, refresh mode, and initialization

## Usage

```hcl
locals {
  dynamic_tables = {
    "sales_summary" = {
      name       = "SALES_SUMMARY_DT"
      database   = "ANALYTICS_DB"
      schema     = "GOLD"
      warehouse  = "TRANSFORM_WH"
      query      = "SELECT region, SUM(amount) as total_sales FROM ANALYTICS_DB.SILVER.SALES GROUP BY region"
      target_lag = "1 hour"
      comment    = "Aggregated sales by region"
    }
    "customer_metrics" = {
      name         = "CUSTOMER_METRICS_DT"
      database     = "ANALYTICS_DB"
      schema       = "GOLD"
      warehouse    = "TRANSFORM_WH"
      query        = "SELECT customer_id, COUNT(*) as order_count FROM ANALYTICS_DB.SILVER.ORDERS GROUP BY customer_id"
      target_lag   = "30 minutes"
      refresh_mode = "INCREMENTAL"
      comment      = "Customer order metrics"
    }
  }
}

module "dynamic_tables" {
  source = "path/to/terraform-snowflake-dynamic-table"

  dynamic_table_configs = local.dynamic_tables
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| snowflake | >= 0.87.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| dynamic_table_configs | Map of configuration objects for Snowflake dynamic tables | map(object) | no |

### dynamic_table_configs Object Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| name | string | - | Dynamic table identifier (required) |
| database | string | - | Database where the dynamic table resides (required) |
| schema | string | - | Schema where the dynamic table resides (required) |
| warehouse | string | - | Warehouse used for refreshing the dynamic table (required) |
| query | string | - | SQL query defining the dynamic table (required) |
| target_lag | string | "1 hour" | Maximum lag time for data freshness |
| refresh_mode | string | "AUTO" | Refresh mode (AUTO, FULL, INCREMENTAL) |
| initialize | string | "ON_CREATE" | When to initialize (ON_CREATE, ON_SCHEDULE) |
| comment | string | null | Description of the dynamic table |

### Valid Target Lag Formats

- `N second(s)` - e.g., "30 seconds"
- `N minute(s)` - e.g., "5 minutes"
- `N hour(s)` - e.g., "1 hour"
- `N day(s)` - e.g., "1 day"

### Valid Refresh Modes

- `AUTO` - Snowflake determines the best refresh method
- `FULL` - Complete refresh of the dynamic table
- `INCREMENTAL` - Only process changed data

## Outputs

| Name | Description |
|------|-------------|
| dynamic_table_names | Map of dynamic table names keyed by identifier |
| dynamic_table_fully_qualified_names | Map of fully qualified dynamic table names |
| dynamic_table_target_lags | Map of target lag settings |
| dynamic_table_refresh_modes | Map of refresh modes |
| dynamic_tables | All dynamic table resources |

## Validation

The module validates inputs and provides descriptive error messages for:

- Empty dynamic table name
- Empty database name
- Empty schema name
- Empty warehouse name
- Empty query
- Invalid refresh mode
- Invalid initialize value
- Invalid target lag format

## License

MIT License - See [LICENSE](LICENSE) for details.
