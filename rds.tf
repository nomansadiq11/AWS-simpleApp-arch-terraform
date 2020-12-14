module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "sqlserver-ex"
  engine_version    = "14.00.1000.169.v1"
  instance_class    = "db.t2.medium"
  allocated_storage = 20
  storage_encrypted = false

  name     = null # "demodb"
  username = "demouser"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "1433"


  vpc_security_group_ids = [aws_security_group.DB-SG-SSH.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

   tags = {
    Name        = "QMS-DB-Server"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }

  # DB subnet group
  subnet_ids = [aws_subnet.PrivateSubnet.id, aws_subnet.PrivateSubnet2.id]

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"

  create_db_parameter_group = false
  license_model             = "license-included"

  timezone = "Central Standard Time"

  # Database Deletion Protection
  deletion_protection = false

  # DB options
  major_engine_version = "14.00"

  options = []
}