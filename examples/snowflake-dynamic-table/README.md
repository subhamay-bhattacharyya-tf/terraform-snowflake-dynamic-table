# Snowflake Dynamic Table Example

This example demonstrates advanced usage of the Snowflake Dynamic Table module with multiple dynamic tables.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Configuration

This example creates multiple dynamic tables for a data pipeline:
- Bronze to Silver transformation tables
- Silver to Gold aggregation tables
- Various target lag and refresh mode configurations

## Outputs

- `dynamic_table_names` - Names of the created dynamic tables
- `dynamic_table_fully_qualified_names` - Fully qualified names of the dynamic tables
- `dynamic_table_target_lags` - Target lag settings for each table
