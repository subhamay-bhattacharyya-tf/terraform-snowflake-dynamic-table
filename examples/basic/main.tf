# Example: Basic Dynamic Table Module Usage
#
# This example demonstrates how to use the snowflake-dynamic-table module
# to create a simple dynamic table.

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
    }
  }
}

module "dynamic_tables" {
  source = "../.."

  dynamic_table_configs = local.dynamic_tables
}
