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

# Flatten grants for all dynamic tables
locals {
  dynamic_table_grants = flatten([
    for dt_key, dt in var.dynamic_table_configs : [
      for grant in coalesce(dt.grants, []) : {
        dt_key     = dt_key
        role_name  = grant.role_name
        privileges = grant.privileges
        database   = dt.database
        schema     = dt.schema
        name       = dt.name
      }
    ]
  ])
}

resource "snowflake_grant_privileges_to_account_role" "dynamic_table_grants" {
  for_each = {
    for idx, grant in local.dynamic_table_grants :
    "${grant.dt_key}_${grant.role_name}" => grant
  }

  privileges        = each.value.privileges
  account_role_name = each.value.role_name

  on_schema_object {
    object_type = "DYNAMIC TABLE"
    object_name = "\"${each.value.database}\".\"${each.value.schema}\".\"${each.value.name}\""
  }

  depends_on = [snowflake_dynamic_table.this]
}
