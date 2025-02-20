# output "azs_info" {
#     value = data.aws_availability_zones.available.names
# }

# output "public_subnet_info" {
#     value = aws_subnet.public  
# }

# output "eip_info" {
#     value = aws_eip.nat_eip
# }
# output "default_vpc_info" {
#     value =  data.aws_vpc.default
# }
output "vpc_cidr" {
    value =  data.aws_vpc.default
}
output "default_vpc_main_rt_id" {
  value = data.aws_vpc.default.main_route_table_id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id // * means all the ids we will get
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id // * means all the ids we will get
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id // * means all the ids we will get
}