resource "aws_docdb_cluster" "main" {
  cluster_identifier              = "${var.name}-${var.env}"
  engine                          = "docdb"
  engine_version                  = var.engine_version
  master_username                 =
  master_password                 =
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  skip_final_snapshot             = true
  db_subnet_group_name            =
  vpc_security_group_ids          =
  port                            = var.port
  db_cluster_parameter_group_name =
  storage_encrypted               = true
  kms_key_id                      = var.kms_key_id
  tags                            = merge(var.tags, {Name="${var.name}-${var.env}-docdb"})
}