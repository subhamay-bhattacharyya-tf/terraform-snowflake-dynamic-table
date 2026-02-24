# -----------------------------------------------------------------------------
# Terraform Snowflake Dynamic Table Module - Variables
# -----------------------------------------------------------------------------
# This file defines the input variables for the Snowflake dynamic table module.
# It uses a map-based configuration to support creating multiple dynamic tables
# with validation rules for all required and optional properties.
# -----------------------------------------------------------------------------

variable "dynamic_table_configs" {
  description = "Map of configuration objects for Snowflake dynamic tables"
  type = map(object({
    name         = string
    database     = string
    schema       = string
    warehouse    = string
    query        = string
    target_lag   = optional(string, "1 hour")
    refresh_mode = optional(string, "AUTO")
    initialize   = optional(string, "ON_CREATE")
    comment      = optional(string, null)
    grants = optional(list(object({
      role_name  = string
      privileges = list(string)
    })), [])
  }))
  default = {}

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : length(dt.name) > 0])
    error_message = "Dynamic table name must not be empty."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : length(dt.database) > 0])
    error_message = "Database name must not be empty."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : length(dt.schema) > 0])
    error_message = "Schema name must not be empty."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : length(dt.warehouse) > 0])
    error_message = "Warehouse name must not be empty."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : length(dt.query) > 0])
    error_message = "Query must not be empty."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : contains(["AUTO", "FULL", "INCREMENTAL"], upper(dt.refresh_mode))])
    error_message = "Invalid refresh_mode. Valid values: AUTO, FULL, INCREMENTAL."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : contains(["ON_CREATE", "ON_SCHEDULE"], upper(dt.initialize))])
    error_message = "Invalid initialize. Valid values: ON_CREATE, ON_SCHEDULE."
  }

  validation {
    condition     = alltrue([for k, dt in var.dynamic_table_configs : can(regex("^\\d+\\s+(downstream|second|seconds|minute|minutes|hour|hours|day|days|month|months)$", lower(dt.target_lag)))])
    error_message = "Invalid target_lag format. Use format like '1 hour', '30 minutes', '1 day', 'downstream'."
  }
}
