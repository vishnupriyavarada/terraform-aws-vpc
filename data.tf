data "aws_availability_zones" "available" {
  state = "available"
}

// default VPC (main) 
data "aws_vpc" "default" {
  default = true
}

# // default VPC 
data "aws_route_table" "default-rt" {
  vpc_id = local.default_vpc_id //with this you say its default vpc
  filter {
    name = "association.main" // this should be association.main
    values = ["true"]
  }    
}
