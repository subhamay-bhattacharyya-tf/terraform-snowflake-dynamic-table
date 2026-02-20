# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module - Advanced Example
# -----------------------------------------------------------------------------
# This example demonstrates advanced usage of the Snowflake dynamic table
# module to create multiple dynamic tables with various configurations
# including different target lags, refresh modes, and data pipeline patterns.
# -----------------------------------------------------------------------------

locals {
  dynamic_tables = {
    "orders_cleaned" = {
      name       = "ORDERS_CLEANED_DT"
      database   = "ANALYTICS_DB"
      schema     = "SILVER"
      warehouse  = "TRANSFORM_WH"
      query      = <<-EOT
        SELECT 
          order_id,
          customer_id,
          COALESCE(amount, 0) as amount,
          order_date,
          region
        FROM ANALYTICS_DB.BRONZE.RAW_ORDERS
        WHERE order_id IS NOT NULL
      EOT
      target_lag = "30 minutes"
      comment    = "Cleaned orders data from Bronze to Silver layer"
    }
    "sales_by_region" = {
      name         = "SALES_BY_REGION_DT"
      database     = "ANALYTICS_DB"
      schema       = "GOLD"
      warehouse    = "TRANSFORM_WH"
      query        = <<-EOT
        SELECT 
          region,
          DATE_TRUNC('day', order_date) as order_day,
          COUNT(*) as order_count,
          SUM(amount) as total_sales
        FROM ANALYTICS_DB.SILVER.ORDERS_CLEANED_DT
        GROUP BY region, DATE_TRUNC('day', order_date)
      EOT
      target_lag   = "1 hour"
      refresh_mode = "INCREMENTAL"
      comment      = "Daily sales aggregation by region for dashboards"
    }
    "customer_lifetime_value" = {
      name         = "CUSTOMER_LTV_DT"
      database     = "ANALYTICS_DB"
      schema       = "GOLD"
      warehouse    = "TRANSFORM_WH"
      query        = <<-EOT
        SELECT 
          customer_id,
          COUNT(*) as total_orders,
          SUM(amount) as lifetime_value,
          MIN(order_date) as first_order,
          MAX(order_date) as last_order
        FROM ANALYTICS_DB.SILVER.ORDERS_CLEANED_DT
        GROUP BY customer_id
      EOT
      target_lag   = "1 day"
      refresh_mode = "FULL"
      comment      = "Customer lifetime value metrics"
    }
    "real_time_inventory" = {
      name       = "REAL_TIME_INVENTORY_DT"
      database   = "ANALYTICS_DB"
      schema     = "GOLD"
      warehouse  = "STREAMLIT_WH"
      query      = <<-EOT
        SELECT 
          product_id,
          warehouse_location,
          SUM(quantity) as current_stock
        FROM ANALYTICS_DB.SILVER.INVENTORY_MOVEMENTS
        GROUP BY product_id, warehouse_location
      EOT
      target_lag = "1 minute"
      comment    = "Near real-time inventory levels for operational dashboards"
    }
  }
}

module "dynamic_tables" {
  source = "../.."

  dynamic_table_configs = local.dynamic_tables
}
