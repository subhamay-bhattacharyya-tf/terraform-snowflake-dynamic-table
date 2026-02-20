# Changelog

All notable changes to this project will be documented in this file.

## 1.0.0 (2026-02-20)

### ⚠ BREAKING CHANGES

* Repository restructured from snowflake-warehouse to snowflake-dynamic-table module with root-level Terraform files

- Remove snowflake-warehouse module and consolidate to root module structure
- Replace snowflake-warehouse example with snowflake-dynamic-table example
- Add main.tf, outputs.tf, variables.tf, and versions.tf to root directory
- Migrate from Node.js property tests to Go-based Terratest framework
- Update CI/CD pipeline to use Terratest instead of property tests
- Simplify CI workflow paths to track root *.tf files and examples directory
- Remove module-specific matrix strategy from terraform-validate job
- Update examples-validate to test basic and snowflake-dynamic-table examples
- Remove .kiro/specs documentation for snowflake-warehouse-module
- Update action versions (checkout@v4, setup-node@v4, semantic-release-action@v4)
- Add explicit semantic-release plugin versions for reproducible releases
- Consolidate Terraform version to hardcoded 1.3.0 in CI environment

### Features

* convert to Snowflake Dynamic Table module with single-module layout ([1fee15e](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-dynamic-table/commit/1fee15ef6199e8496ca0db7fadd3bff6efdc4cb9))

## [unreleased]

### 🚀 Features

- [**breaking**] Convert to Snowflake Dynamic Table module with single-module layout

### 🚜 Refactor

- Update module source references and expand target_lag validation

### 📚 Documentation

- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update module source references and target_lag validation
- Update CHANGELOG.md [skip ci]

### 🎨 Styling

- *(main.tf)* Align Snowflake dynamic table resource attributes

### ⚙️ Miscellaneous Tasks

- Expand test coverage and add environment variable configuration
- Update package metadata for dynamic table module
