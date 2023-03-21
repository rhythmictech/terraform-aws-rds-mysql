########################################
# General Vars
########################################

variable "name" {
  default     = "mysql-rds"
  description = "common name for resources in this module"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to supported resources"
  type        = map(string)
}


########################################
# Access Control Vars
########################################

variable "allowed_security_groups" {
  default     = []
  description = "IDs of security groups allowed to reach the database (not Names)"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  default     = []
  description = "CIDR blocks allowed to reach the database"
  type        = list(string)
}

variable "allowed_ipv6_cidr_blocks" {
  default     = []
  description = "IPv6 CIDR blocks allowed to reach the database"
  type        = list(string)
}

########################################
# Database Config Vars
########################################

variable "backup_retention_period" {
  default     = 5
  description = "How long to keep RDS backups (in days)"
  type        = number
}

variable "cloudwatch_log_exports" {
  description = "Log types to export to CloudWatch"
  type        = list(string)

  default = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
}

variable "copy_tags_to_snapshot" {
  default     = true
  description = "If `true`, RDS instance tags will be copied to snapshots"
  type        = bool
}

variable "enable_deletion_protection" {
  default     = true
  description = "If `true`, deletion protection will be turned on for the RDS instance(s)"
  type        = bool
}

variable "engine_version" {
  default     = "5.7"
  description = "Version of database engine to use"
  type        = string
}

variable "final_snapshot_identifier" {
  default     = null
  description = "name of final snapshot (will be computed automatically if not specified)"
  type        = string
}

variable "iam_database_authentication_enabled" {
  default     = false
  description = "Whether or not to enable IAM DB authentication"
  type        = bool
}

variable "param_group_family_name" {
  default     = null
  description = "Family name of DB parameter group. Valid family names can be queried using aws cli: aws rds describe-db-engine-versions --query 'DBEngineVersions[].DBParameterGroupFamily'"
  type        = string
}

variable "parameter_group_name" {
  default = null
  description = "Name of parameter group. conflicts with parameters"
  type = string
}

variable "parameters" {
  description = "Database parameters (will create parameter group if not null)"

  default = [
    {
      apply_method = "immediate"
      name         = "character_set_database"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "character_set_connection"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "character_set_filesystem"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "character_set_results"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "character_set_server"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "character_set_client"
      value        = "utf8"
    },
    {
      apply_method = "immediate"
      name         = "collation_connection"
      value        = "utf8_bin"
    },
    {
      apply_method = "immediate"
      name         = "collation_server"
      value        = "utf8_bin"
    },
    {
      apply_method = "immediate"
      name         = "max_allowed_packet"
      value        = "1073741824"
  }]

  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
}

variable "password" {
  default     = null
  description = "Master password (if not set, one will be generated dynamically and exposed through a secret)"
  type        = string
}

variable "password_length" {
  default     = 30
  description = "Master password length (not used if `password` is set)"
  type        = number
}

variable "pass_version" {
  default     = 1
  description = "Increment to force master user password change (not used if `password` is set)"
  type        = number
}

variable "performance_insights_enabled" {
  default     = false
  description = "If true, performance insights will be enabled"
  type        = bool
}

variable "skip_final_snapshot" {
  default     = false
  description = "If `true` no final snapshot will be taken on termination"
  type        = bool
}

variable "username" {
  description = "username of master user"
  type        = string
  default     = "mysql_user"
}

########################################
# Instance Vars
########################################

variable "identifier_prefix" {
  default     = null
  description = "DB identifier prefix (will be generated by AWS automatically if not specified)"
  type        = string
}

variable "instance_class" {
  default     = "db.t3.small"
  description = "What instance type to use"
  type        = string
}

variable "monitoring_interval" {
  default     = 0
  description = "Monitoring interval in seconds (`0` to disable enhanced monitoring)"
  type        = number
}

variable "monitoring_role_arn" {
  default     = null
  description = "Enhanced Monitoring ARN (blank to omit)"
  type        = string
}

variable "multi_az" {
  default     = true
  description = "whether to make database multi-az"
  type        = bool
}

variable "storage" {
  default     = 20
  description = "How much storage is available to the database"
  type        = string
}

variable "storage_encrypted" {
  default     = true
  description = "Encrypt DB storage"
  type        = bool
}

variable "storage_type" {
  default     = "gp2"
  description = "What storage backend to use (`gp2` or `standard`. io1 not supported)"
  type        = string
}

########################################
# Networking Vars
########################################

variable "port" {
  description = "Port the database should listen on"
  type        = string
  default     = "3306"
}

variable "subnet_group_name" {
  description = "name of DB subnet group to place DB in"
  type        = string
}

variable "vpc_id" {
  description = "ID of VPC resources will be created in"
  type        = string
}
