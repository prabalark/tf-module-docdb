resource "aws_security_group" "main" {
  name        = "${var.name}-${var.env}-asg"
  description = "${var.name}-${var.env}-asg"
  vpc_id      = var.vpc_id

  ingress {
    description = "DOCDB"
    protocol    = "tcp"
    from_port   = var.port
    to_port     = var.port
    cidr_blocks = var.allow_app_cidr # sunet_cidrs from internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = merge(var.tags, {Name="${var.name}-${var.env}-docdb"})
  }
}

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