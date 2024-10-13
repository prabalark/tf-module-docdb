output "subnets" {
  value = module.subnets
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.main.*.id
}

output "subnet_cidrs" {
  value = aws_subnet.main.*.cidr_block
}

