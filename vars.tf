variable "vpc_id" {}
variable "allow_app_cidr" {}
variable "name" {
  default = "docdb"
}
variable "env" {}
variable "engine_version" {}
variable "port" {
  default = 27017
}
variable "kms_key_id" {}
variable "tags" {}
variable "subnets" {}
variable "instance_class" {}
variable "instance_count" {}
