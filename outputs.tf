output "region" {
  value = var.region
}


output "db_instance_id" {
  value = aws_db_instance.database.id
}
output "db_instance_subnetgroup_id" {
  value = aws_db_subnet_group.subnet_group_private.id
}
output "db_instance_sg" {
  value = aws_security_group.db_sg.id
}
output "db_sg_id" {
  value = aws_security_group.db_sg.id
}



output "vpc_id" {
  value = aws_vpc.wordpress_vpc.id
}
output "vpc_cidr" {
  value = var.cidr_vpc
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "route_terra_id" {
  value = aws_route_table.route_table.id
}


output "public_1_id" {
  value = aws_subnet.public_1.id
}
output "public_2_id" {
  value = aws_subnet.public_2.id
}
output "public_3_id" {
  value = aws_subnet.public_3.id
}


output "private_1_id" {
  value = aws_subnet.private_1.id
}
output "private_2_id" {
  value = aws_subnet.private_2.id
}
output "private_3_id" {
  value = aws_subnet.private_3.id
}
output "subnet_group_terra" {
  value = aws_db_subnet_group.subnet_group_private.id
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}


output "alp_dns" {
  value = aws_lb.app_lb.dns_name
}

output "dbend" {
  value = aws_db_instance.database.endpoint
}
output "dns_records" {
  value = aws_route53_zone.zone.name_servers
}
