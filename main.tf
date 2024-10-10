resource "aws_docdb_cluster" "main" {
  cluster_identifier              = ""
  engine                          = "docdb"
  engine_version                  = ""
  master_username                 = ""
  master_password                 = ""
  backup_retention_period         =
  preferred_backup_window         =
  skip_final_snapshot             =
  db_subnet_group_name            =
  vpc_security_group_ids          =
  port                            =
  db_cluster_parameter_group_name =
  storage_encrypted               =
  kms_key_id                      =
  tags                            =
}