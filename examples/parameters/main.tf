#trivy:ignore:AVD-AWS-0176
module "basic" {
  source = "../.."

  name              = "app-database"
  identifier_prefix = "appdb"
  instance_class    = "db.m5.xlarge"
  storage           = 100
  subnet_group_name = "db_subnet_group"
  vpc_id            = "vpc-1234567890"

  parameters = [
    {
      name  = "character_set_database"
      value = "utf8"
    },
    {
      name  = "character_set_connection"
      value = "utf8"
    },
    {
      name  = "character_set_filesystem"
      value = "utf8"
    },
    {
      name  = "character_set_results"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "collation_connection"
      value = "utf8_bin"
    },
    {
      name  = "collation_server"
      value = "utf8_bin"
    },
    {
      name  = "max_allowed_packet"
      value = "1073741824"
    },
    {
      name  = "query_cache_size"
      value = "100663296"
    },
    {
      name  = "tx_isolation"
      value = "READ-COMMITTED"
    },
    {
      name  = "slow_query_log"
      value = "1"
  }]
}
