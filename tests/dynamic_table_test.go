package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestValidInputAcceptance validates that the module accepts valid configurations
func TestValidInputAcceptance(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic",
		NoColor:      true,
	})

	// Run terraform init and validate
	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.NoError(t, err, "terraform validate should succeed for valid configuration")
}

// TestAdvancedExampleValidation validates the advanced example configuration
func TestAdvancedExampleValidation(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/snowflake-dynamic-table",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.NoError(t, err, "terraform validate should succeed for advanced example")
}

// TestEmptyNameRejection validates that empty name is rejected
func TestEmptyNameRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_empty_name",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for empty name")
	assert.Contains(t, err.Error(), "Dynamic table name must not be empty")
}

// TestEmptyDatabaseRejection validates that empty database is rejected
func TestEmptyDatabaseRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_empty_database",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for empty database")
	assert.Contains(t, err.Error(), "Database name must not be empty")
}

// TestEmptySchemaRejection validates that empty schema is rejected
func TestEmptySchemaRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_empty_schema",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for empty schema")
	assert.Contains(t, err.Error(), "Schema name must not be empty")
}

// TestEmptyWarehouseRejection validates that empty warehouse is rejected
func TestEmptyWarehouseRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_empty_warehouse",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for empty warehouse")
	assert.Contains(t, err.Error(), "Warehouse name must not be empty")
}

// TestEmptyQueryRejection validates that empty query is rejected
func TestEmptyQueryRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_empty_query",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for empty query")
	assert.Contains(t, err.Error(), "Query must not be empty")
}

// TestInvalidRefreshModeRejection validates that invalid refresh_mode is rejected
func TestInvalidRefreshModeRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_refresh_mode",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for invalid refresh_mode")
	assert.Contains(t, err.Error(), "Invalid refresh_mode")
}

// TestInvalidInitializeRejection validates that invalid initialize is rejected
func TestInvalidInitializeRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_initialize",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for invalid initialize")
	assert.Contains(t, err.Error(), "Invalid initialize")
}

// TestInvalidTargetLagRejection validates that invalid target_lag format is rejected
func TestInvalidTargetLagRejection(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/invalid_target_lag",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.Error(t, err, "terraform validate should fail for invalid target_lag")
	assert.Contains(t, err.Error(), "Invalid target_lag format")
}

// TestDefaultValuesApplied validates that default values are correctly applied
func TestDefaultValuesApplied(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/minimal_config",
		NoColor:      true,
	})

	_, err := terraform.InitE(t, terraformOptions)
	assert.NoError(t, err, "terraform init should succeed")

	_, err = terraform.ValidateE(t, terraformOptions)
	assert.NoError(t, err, "terraform validate should succeed with minimal config using defaults")
}
