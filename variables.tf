variable "name" {
  description = "Enter name of the cluster identifier"
  type = string
  default = "fdcluster"
}

variable "create_cluster" {
    description = "Create cluster true or false"
    type = bool
    default = true
  
}

variable "engine" {
    description = "The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql"
    type = string
    default = "aurora-mysql"
}

variable "engine_version"{
    description = "The database engine version. Updating this argument results in an outag"
    type = string
    default = ""
}

variable "engine_mode" {
    description = "The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned`"
    type = string
    default = "provisioned"
  
}
variable "availability_zones" {
    description = "value"
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e"]
}

variable "database_name" {
    description = "Name for an automatically created database on cluster creation; default to `fd-demo`"
    type = string
    default = "fd-demo"
      
}

variable "master_username" {
  description = "value"
  type = string
  default = "fd-root"
}

variable "master_password" {
    description = "Password for the master DB user. Note - when specifying a value here"
    type = string
  
}

variable "db_instance_port" {
    description = "The port on which the DB accepts connections. Defaults to `3306`"
    type = number
    default = 3306
  
}
variable "backup_retention_period" {
    description = "The days to retain backups for. Default `7`"
    type = number
    default = 5
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the `backup_retention_period` parameter. Time in UTC"
  type = string
  default = "02:00-03:00"
}

variable "skip_final_snapshot" {
    description = "Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created"
    type = bool
    default = true
}

variable "create_db_subnet_group" {
    description = "Create subnet group true or false. Default `true`"
    type = bool
    default = true
}

variable "subnet_ids" {
    description = "value"
    type = list(string)
}

variable "db_subnet_group_name" {
    description = "The name of the subnet group name (existing or created New)"
    type = string
    default = null
}

variable "allow_major_version_upgrade" {
    description = "Enable to allow major engine version upgrades when changing engine versions. Defaults to `false`"
    type = bool
    default = false  
}

variable "apply_immediately" {
    description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
    type = bool
    default = false
}

variable "copy_tags_to_snapshot" {
    description = "Copy all Cluster `tags` to snapshots. Defaults to `true`"
    type = bool
    default = true
}

variable "iam_roles" {
    description = "Map of IAM roles and supported feature names to associate with the cluster"
    type = list(string)
    default = [ ]
}

variable "kms_key_id" {
    description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true`"
    type = string
    default = ""
  
}

variable "storage_encrypted" {
    description = "Specifies whether the DB cluster is encrypted. The default is `true`"
    type = bool
    default = true
  
}
variable "vpc_security_group_ids" {
    description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
    type = list(string)
    default = [ ]
  
}

# variable "vpc_id" {
#     description = "ID of the VPC where to create security group"
#     type        = string
#     default     = ""
# }

variable "create_cluster_parameter_group" {
    description = "Create cluster parameter group is true or false. Default `true`"
    type = bool
    default = true  
}

variable "db_cluster_parameter_group_name" {
    description = "provide existing parameter group name"
    type = string
    default = null
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type = map(string)
    default = {}
}

variable "restore_to_point_in_time" {
  description = "Map of nested attributes for cloning Aurora cluster"
  type        = map(string)
  default     = {}
}

variable "instance_class" {
    description = "Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling"
    type = string
    default = "db.t2.small"
  
}

variable "publicly_accessible" {
    description = "Determines whether instances are publicly accessible. Default false"
    type = bool
    default = false
  
}

variable "create_db_parameter_group" {
    description = "value"
    type = bool
    default = false
  
}

variable "db_parameter_group_name" {
    description = "The name of the DB parameter group to associate with instances"
    type = string
    default = ""
}

