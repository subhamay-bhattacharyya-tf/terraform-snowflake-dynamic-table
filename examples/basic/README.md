# Basic Dynamic Table Example

This example demonstrates basic usage of the Snowflake Dynamic Table module.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Configuration

This example creates a single dynamic table that aggregates sales data by region with a 1-hour target lag, and grants SELECT privileges to the ANALYST_ROLE.

## Outputs

- `dynamic_table_names` - Names of the created dynamic tables
- `dynamic_table_fully_qualified_names` - Fully qualified names of the dynamic tables
- `dynamic_table_grants` - Grants applied to the dynamic tables
