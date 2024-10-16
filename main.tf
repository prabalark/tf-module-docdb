resource "aws_security_group" "main" {
  name        = "${var.name}-${var.env}-asg"
  description = "${var.name}-${var.env}-asg"
  vpc_id      = var.vpc_id

  ingress {
    description = "DOCDB"
    protocol    = "tcp"
    from_port   = var.port
    to_port     = var.port
    cidr_blocks = var.allow_db_cidr # sunet_cidrs from internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {Name="${var.name}-${var.env}-docdbsg"})

}

resource "aws_docdb_subnet_group" "main" {
  name       = "${var.name}-${var.env}"
  subnet_ids = var.subnets

  tags       = merge(var.tags, {Name="${var.name}-${var.env}-subg"})
}

resource "aws_docdb_cluster_parameter_group" "main" {
  family      = "docdb4.0"
  name        = "${var.name}-${var.env}"
  description = "${var.name}-${var.env}"

  tags        = merge(var.tags, {Name="${var.name}-${var.env}-pg"})
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.instance_count # taking as 1
  identifier         = "${var.name}-${var.env}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.instance_class
}

resource "aws_docdb_cluster" "main" {
  cluster_identifier              = "${var.name}-${var.env}"
  engine                          = "docdb"
  engine_version                  = var.engine_version
  master_username                 = data.aws_ssm_parameter.db_user.value
  master_password                 = data.aws_ssm_parameter.db_pass.value
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_docdb_subnet_group.main.name
  vpc_security_group_ids          = [aws_security_group.main.id]
  port                            = var.port
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.main.name
  storage_encrypted               = true
  kms_key_id                      = var.kms_arn
  tags                            = merge(var.tags, {Name="${var.name}-${var.env}-docdb"})
}