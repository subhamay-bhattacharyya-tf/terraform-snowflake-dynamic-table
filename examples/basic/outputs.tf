# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module - Basic Example Outputs
# -----------------------------------------------------------------------------
# This file defines the output values for the basic example.
# -----------------------------------------------------------------------------

output "dynamic_table_names" {
  description = "Names of the created dynamic tables"
  value       = module.dynamic_tables.dynamic_table_names
}

output "dynamic_table_fully_qualified_names" {
  description = "Fully qualified names of the dynamic tables"
  value       = module.dynamic_tables.dynamic_table_fully_qualified_names
}

output "dynamic_table_grants" {
  description = "Grants applied to the dynamic tables"
  value       = module.dynamic_tables.dynamic_table_grants
}
