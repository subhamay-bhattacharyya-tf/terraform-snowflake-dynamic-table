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
