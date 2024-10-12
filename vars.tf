variable "vpc_id" {}
variable "allow_db_cidr" {}
variable "name" {
  default = "docdb"
}
variable "env" {}
variable "engine_version" {}
variable "port" {
  default = 27017
}
variable "kms_arn" {}
variable "tags" {}
variable "subnets" {}
variable "instance_class" {}
variable "instance_count" {}
