module "aurora_mysql" {
  source            = "../../"
  name              = "fd-test-mysql"
  engine            = "aurora-mysql"
  engine_version    = "5.7.mysql_aurora.2.03.2"
  master_password   = "Password#321"
  subnet_ids        = ["subnet-dbecd791", "subnet-113f802f", "subnet-c9b8cc95", "subnet-67e5c868", "subnet-96442ff1", "subnet-8da3d5a3"]
  storage_encrypted = false

}