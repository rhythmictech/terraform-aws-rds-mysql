# terraform-aws-rds-mysql
[![tflint](https://github.com/rhythmictech/terraform-aws-rds-mysql/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-mysql/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-rds-mysql/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-mysql/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-rds-mysql/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-mysql/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-rds-mysql/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-mysql/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-rds-mysql/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-rds-mysql/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

Create and manage an RDS MySQL instance. Includes the ability to manage the master password in Secrets Manager and manage the security group that controls RDS access.

## Usage
```
module "rds-mysql" {
  source = "rhythmictech/rds-mysql/aws"

  subnet_group_name = "db_subnet_group"
  vpc_id            = "vpc-1234567890"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.56.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_password"></a> [password](#module\_password) | rhythmictech/secretsmanager-random-secret/aws | ~>1.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ipv4_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ipv6_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| <a name="input_allowed_ipv6_cidr_blocks"></a> [allowed\_ipv6\_cidr\_blocks](#input\_allowed\_ipv6\_cidr\_blocks) | IPv6 CIDR blocks allowed to reach the database | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | IDs of security groups allowed to reach the database (not Names) | `list(string)` | `[]` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | How long to keep RDS backups (in days) | `number` | `5` | no |
| <a name="input_cloudwatch_log_exports"></a> [cloudwatch\_log\_exports](#input\_cloudwatch\_log\_exports) | Log types to export to CloudWatch | `list(string)` | <pre>[<br>  "audit",<br>  "error",<br>  "general",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | If `true`, RDS instance tags will be copied to snapshots | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If `true`, deletion protection will be turned on for the RDS instance(s) | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Database Engine to use for RDS (mysql or mariadb are acceptable here) | `string` | `"mysql"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of database engine to use | `string` | `"5.7"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | name of final snapshot (will be computed automatically if not specified) | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Whether or not to enable IAM DB authentication | `bool` | `false` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | DB identifier prefix (will be generated by AWS automatically if not specified) | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | What instance type to use | `string` | `"db.t3.small"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | If encrypting database with a KMS key, specify the id of the KMS key here. Note that storage\_encrypted will also need to be set to true. | `string` | `null` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Monitoring interval in seconds (`0` to disable enhanced monitoring) | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | Enhanced Monitoring ARN (blank to omit) | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | whether to make database multi-az | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | common name for resources in this module | `string` | `"mysql-rds"` | no |
| <a name="input_param_group_family_name"></a> [param\_group\_family\_name](#input\_param\_group\_family\_name) | Family name of DB parameter group. Valid family names can be queried using aws cli: aws rds describe-db-engine-versions --query 'DBEngineVersions[].DBParameterGroupFamily' | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of parameter group. conflicts with parameters | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Database parameters (will create parameter group if not null) | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_database",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_connection",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_filesystem",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_results",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_server",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "character_set_client",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "collation_connection",<br>    "value": "utf8_bin"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "collation_server",<br>    "value": "utf8_bin"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "max_allowed_packet",<br>    "value": "1073741824"<br>  }<br>]</pre> | no |
| <a name="input_pass_version"></a> [pass\_version](#input\_pass\_version) | Increment to force master user password change (not used if `password` is set) | `number` | `1` | no |
| <a name="input_password"></a> [password](#input\_password) | Master password (if not set, one will be generated dynamically and exposed through a secret) | `string` | `null` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Master password length (not used if `password` is set) | `number` | `30` | no |
| <a name="input_password_override_special_characters"></a> [password\_override\_special\_characters](#input\_password\_override\_special\_characters) | Set of special characters to allow when creating the password. The default is suitable for generating MySQL passwords for RDS. NOTE: If you created your database on a module version before 3.3.0, you need to explicitly set this value to an empty string '' in order to keep your password from being regenerated. | `string` | `"#$%^*()-=_+[]{};<>?,."` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | If true, performance insights will be enabled | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | Port the database should listen on | `string` | `"3306"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | If `true` no final snapshot will be taken on termination | `bool` | `false` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | How much storage is available to the database | `string` | `20` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Encrypt DB storage | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | What storage backend to use (`gp2` or `standard`. io1 not supported) | `string` | `"gp2"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | name of DB subnet group to place DB in | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to supported resources | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | username of master user | `string` | `"mysql_user"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC resources will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | RDS database address |
| <a name="output_instance_connection_info"></a> [instance\_connection\_info](#output\_instance\_connection\_info) | Object containing connection info |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Instance ID of RDS DB |
| <a name="output_password_secret_arn"></a> [password\_secret\_arn](#output\_password\_secret\_arn) | Password secret ARN |
| <a name="output_password_secret_version_id"></a> [password\_secret\_version\_id](#output\_password\_secret\_version\_id) | Password secret version |
| <a name="output_username"></a> [username](#output\_username) | Master username |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
