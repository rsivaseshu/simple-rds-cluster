locals {
  is_serverless     = var.engine_mode == "serverless"
  engine_version    = local.is_serverless ? null : var.engine_version
  
  db_subnet_group_name = var.create_db_subnet_group ? aws_db_subnet_group.this[*].name : var.db_subnet_group_name
  internal_db_subnet_group_name = try(coalesce(var.db_subnet_group_name, var.name), "")
  db_cluster_parameter_group_name = var.create_cluster_parameter_group ? aws_rds_cluster_parameter_group.this[*].name : var.db_cluster_parameter_group_name
  internal_db_cluster_parameter_group_name = try(coalesce(var.db_cluster_parameter_group_name, var.name), "")
}

resource "aws_rds_cluster" "this" {
  count = var.create_cluster ? 1 : 0
  cluster_identifier      = var.name
  engine                  = var.engine
  engine_version          = local.engine_version
  engine_mode             = var.engine_mode
  
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  port                    =  var.db_instance_port
  
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately = var.apply_immediately 


  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  iam_roles = var.iam_roles

  kms_key_id           = var.kms_key_id
  storage_encrypted    = var.storage_encrypted

  db_subnet_group_name   = local.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  db_cluster_parameter_group_name = local.db_cluster_parameter_group_name

  tags = var.tags


  dynamic "restore_to_point_in_time" {
    for_each = length(keys(var.restore_to_point_in_time)) == 0 ? [] : [var.restore_to_point_in_time]

    content {
      source_cluster_identifier  = restore_to_point_in_time.value.source_cluster_identifier
      restore_type               = lookup(restore_to_point_in_time.value, "restore_type", null)
      use_latest_restorable_time = lookup(restore_to_point_in_time.value, "use_latest_restorable_time", null)
      restore_to_time            = lookup(restore_to_point_in_time.value, "restore_to_time", null)
    }
  }
}

resource "aws_rds_cluster_instance" "this" {
#  count              = 2
  identifier         = aws_rds_cluster.this[*].cluster_identifier #need to be change later
  cluster_identifier = aws_rds_cluster.this[*].id

  engine              = aws_rds_cluster.this[*].engine
  engine_version      = aws_rds_cluster.this[*].engine_version
  instance_class      = var.instance_class
  publicly_accessible = var.publicly_accessible

  db_subnet_group_name    = local.db_subnet_group_name
  db_parameter_group_name = var.db_parameter_group_name
  apply_immediately       = var.apply_immediately 

#  monitoring_role_arn  = var.rds_enhanced_monitoring_arn
#  monitoring_interval  = "0"
  
#  promotion_tier = 0
  preferred_backup_window = var.preferred_backup_window

  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  tags = var.tags
}

resource "aws_db_subnet_group" "this" {
  count = var.create_cluster && var.create_db_subnet_group ? 1 : 0
  
  name       = local.internal_db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

# resource "aws_db_security_group" "this" {
#   name = "rds_sg"

#   ingress {
#     cidr = "10.0.0.0/24"
#   }
# }

# resource "aws_db_parameter_group" "this" {
#   count = var.create_db_parameter_group ? 1 : 0
#   name   = coalesce(var.db_parameter_group_name, "${var.name}-parameter-group")
#   family = "mysql5.6"

#   parameter {
#     name  = "character_set_server"
#     value = "utf8"
#   }

#   parameter {
#     name  = "character_set_client"
#     value = "utf8"
#   }
# }

resource "aws_rds_cluster_parameter_group" "this" {
  count = var.create_cluster_parameter_group ? 1 : 0

  name        = local.internal_db_cluster_parameter_group_name
  family      = "aurora5.6"
  description = "RDS default cluster parameter group"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}


