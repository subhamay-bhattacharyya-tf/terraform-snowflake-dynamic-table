# Test fixture for dynamic table with grants configuration

module "dynamic_tables" {
  source = "../../.."

  dynamic_table_configs = {
    "test_table" = {
      name       = "TEST_DT"
      database   = "TEST_DB"
      schema     = "TEST_SCHEMA"
      warehouse  = "TEST_WH"
      query      = "SELECT 1 as id"
      target_lag = "1 hour"
      grants = [
        {
          role_name  = "ANALYST_ROLE"
          privileges = ["SELECT"]
        },
        {
          role_name  = "DATA_ENGINEER_ROLE"
          privileges = ["SELECT", "OPERATE"]
        }
      ]
    }
  }
}
