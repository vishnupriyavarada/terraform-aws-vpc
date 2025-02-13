//This module is created for general. not pertaining to one project. so give generic names
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  // In a server we can host multiple hosts. instance_tenancy allows it
  instance_tenancy = "default"
 # tags convention. projectname-environment
  tags = merge(
    var.common_tags,
    var.vpc_tags, 
    {
        Name = local.resource_name
    }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # attaching VPC to internet gateway

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name=local.resource_name
    }
  )
}

resource "aws_eip" "nat_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}