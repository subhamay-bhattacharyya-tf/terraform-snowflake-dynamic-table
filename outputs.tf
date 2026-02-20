# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module - Outputs
# -----------------------------------------------------------------------------
# This file defines the output values for the Snowflake dynamic table module.
# Outputs are keyed by the dynamic table identifier for easy reference and
# integration with other Terraform configurations.
# -----------------------------------------------------------------------------

output "dynamic_table_names" {
  description = "The names of the created dynamic tables."
  value       = { for k, v in snowflake_dynamic_table.this : k => v.name }
}

output "dynamic_table_fully_qualified_names" {
  description = "The fully qualified names of the dynamic tables."
  value       = { for k, v in snowflake_dynamic_table.this : k => v.fully_qualified_name }
}

output "dynamic_table_target_lags" {
  description = "The target lag settings of the dynamic tables."
  value       = { for k, dt in var.dynamic_table_configs : k => dt.target_lag }
}

output "dynamic_table_refresh_modes" {
  description = "The refresh modes of the dynamic tables."
  value       = { for k, v in snowflake_dynamic_table.this : k => v.refresh_mode }
}

output "dynamic_tables" {
  description = "All dynamic table resources."
  value       = snowflake_dynamic_table.this
}
