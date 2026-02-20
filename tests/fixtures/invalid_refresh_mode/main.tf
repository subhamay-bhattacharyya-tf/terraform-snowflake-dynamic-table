module "dynamic_tables" {
  source = "../../.."

  dynamic_table_configs = {
    test_dt = {
      name         = "TEST_DT"
      database     = "TEST_DB"
      schema       = "TEST_SCHEMA"
      warehouse    = "TEST_WH"
      query        = "SELECT * FROM test_table"
      target_lag   = "1 hour"
      refresh_mode = "INVALID_MODE"
    }
  }
}
