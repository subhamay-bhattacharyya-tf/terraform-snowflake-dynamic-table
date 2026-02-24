# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module - Basic Example
# -----------------------------------------------------------------------------
# This example demonstrates basic usage of the Snowflake dynamic table module
# to create a simple dynamic table with default settings.
# -----------------------------------------------------------------------------

locals {
  dynamic_tables = {
    "sales_summary" = {
      name       = "SALES_SUMMARY_DT"
      database   = "ANALYTICS_DB"
      schema     = "GOLD"
      warehouse  = "TRANSFORM_WH"
      query      = "SELECT region, SUM(amount) as total_sales FROM ANALYTICS_DB.SILVER.SALES GROUP BY region"
      target_lag = "1 hour"
      comment    = "Aggregated sales data by region"
      grants = [
        {
          role_name  = "ANALYST_ROLE"
          privileges = ["SELECT"]
        }
      ]
    }
  }
}

module "dynamic_tables" {
  source = "../.."

  dynamic_table_configs = local.dynamic_tables
}
