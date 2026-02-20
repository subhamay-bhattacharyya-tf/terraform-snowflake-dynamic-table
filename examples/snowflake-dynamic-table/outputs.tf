output "dynamic_table_names" {
  description = "Names of the created dynamic tables"
  value       = module.dynamic_tables.dynamic_table_names
}

output "dynamic_table_fully_qualified_names" {
  description = "Fully qualified names of the dynamic tables"
  value       = module.dynamic_tables.dynamic_table_fully_qualified_names
}

output "dynamic_table_target_lags" {
  description = "Target lag settings for each dynamic table"
  value       = module.dynamic_tables.dynamic_table_target_lags
}
