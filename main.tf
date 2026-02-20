# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake dynamic tables using a map-based
# configuration. It supports creating single or multiple dynamic tables with
# configurable target lag, refresh mode, and initialization settings in a
# single module call.
# -----------------------------------------------------------------------------

resource "snowflake_dynamic_table" "this" {
  for_each = var.dynamic_table_configs

  name      = each.value.name
  database  = each.value.database
  schema    = each.value.schema
  warehouse = each.value.warehouse
  query     = each.value.query

  target_lag {
    maximum_duration = each.value.target_lag
  }

  refresh_mode = each.value.refresh_mode
  initialize   = each.value.initialize
  comment      = each.value.comment
}
