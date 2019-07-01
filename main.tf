resource "aws_db_instance" "this" {
  allocated_storage                   = var.storage
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = aws_db_subnet_group.mysql.id
  deletion_protection                 = true
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = true
  instance_class                      = var.instance_class
  multi_az                            = var.multi_az
  password                            = random_string.password.result
  port                                = var.port
  storage_encrypted                   = true
  storage_type                        = var.storage_type
  final_snapshot_identifier           = "${var.name}-final-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  username                            = var.username
  vpc_security_group_ids              = [aws_security_group.mysql.id]

  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-mysql-db"
    },
  )
}

resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnet_ids

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-subnet-group"
    },
  )
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    security_groups  = var.allowed_security_groups
    cidr_blocks      = var.allowed_cidr_blocks
    ipv6_cidr_blocks = var.allowed_ipv6_cidr_blocks
  }

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-security-group"
    },
  )
}

resource "random_string" "password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"

  keepers = {
    pass_version = var.pass_version
  }
}

resource "aws_secretsmanager_secret" "password" {
  description = "MySQL database password"

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-mysql-pass-secret"
    },
  )
}

resource "aws_secretsmanager_secret_version" "password_val" {
  secret_id     = aws_secretsmanager_secret.mysql-pass.id
  secret_string = random_string.password.result
}
