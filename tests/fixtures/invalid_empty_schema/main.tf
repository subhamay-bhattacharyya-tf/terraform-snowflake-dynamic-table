module "dynamic_tables" {
  source = "../../.."

  dynamic_table_configs = {
    test_dt = {
      name       = "TEST_DT"
      database   = "TEST_DB"
      schema     = ""
      warehouse  = "TEST_WH"
      query      = "SELECT * FROM test_table"
      target_lag = "1 hour"
    }
  }
}
