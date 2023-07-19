locals {
  create_password_secret    = var.password == null ? true : false
  final_snapshot_identifier = var.final_snapshot_identifier == null ? "${var.name}-final-snapshot" : var.final_snapshot_identifier
  parameter_group_name      = var.parameter_group_name == null ? aws_db_parameter_group.this[0].name : var.parameter_group_name
  password                  = try(module.password.secret, var.password)
  sg_name                   = "${var.name}-db-access"
  param_group_family_name   = var.param_group_family_name == null ? "${var.engine}${var.engine_version}" : var.param_group_family_name
  sg_tags                   = merge(var.tags, { "Name" = "${var.name}-db-access" })
}

module "password" {
  source  = "rhythmictech/secretsmanager-random-secret/aws"
  version = "~>1.2.0"

  name_prefix = "${var.name}-rds-master-password"

  create_secret = local.create_password_secret
  length        = var.password_length
  pass_version  = var.pass_version
  tags          = var.tags
}

resource "aws_db_parameter_group" "this" {
  count = length(var.parameters) > 0 ? 1 : 0

  name_prefix = "${var.name}-param"

  family = local.param_group_family_name

  dynamic "parameter" {
    iterator = each
    for_each = var.parameters

    content {
      name         = each.value.name
      apply_method = each.value.apply_method
      value        = each.value.value
    }
  }
}

resource "aws_db_instance" "this" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = var.subnet_group_name
  deletion_protection                 = var.enable_deletion_protection
  enabled_cloudwatch_logs_exports     = var.cloudwatch_log_exports
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  identifier_prefix                   = var.identifier_prefix
  instance_class                      = var.instance_class
  kms_key_id                          = var.kms_key_id
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = var.monitoring_role_arn
  multi_az                            = var.multi_az
  parameter_group_name                = local.parameter_group_name
  password                            = local.password
  performance_insights_enabled        = var.performance_insights_enabled #tfsec:ignore:aws-rds-enable-performance-insights
  port                                = var.port
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  final_snapshot_identifier           = local.final_snapshot_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.this.id]

  lifecycle {
    ignore_changes = [engine_version, allocated_storage]
  }

  tags = merge(var.tags,
    {
      "Name" = var.name
    }
  )
}

resource "aws_security_group" "this" {
  name_prefix = local.sg_name

  description = "RDS instance SG"
  tags        = local.sg_tags
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_groups" {
  count = length(var.allowed_security_groups)

  description              = "Permit RDS access (${var.allowed_security_groups[count.index]})"
  from_port                = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.allowed_security_groups[count.index]
  to_port                  = var.port
  type                     = "ingress"
}

resource "aws_security_group_rule" "allow_ipv4_cidrs" {
  count = length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  cidr_blocks       = var.allowed_cidr_blocks
  description       = "Permit access to CIDRs"
  from_port         = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = var.port
  type              = "ingress"
}

resource "aws_security_group_rule" "allow_ipv6_cidrs" {
  count = length(var.allowed_ipv6_cidr_blocks) > 0 ? 1 : 0

  cidr_blocks       = var.allowed_ipv6_cidr_blocks
  description       = "Permit access to IPv6 CIDRs"
  from_port         = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = var.port
  type              = "ingress"
}
