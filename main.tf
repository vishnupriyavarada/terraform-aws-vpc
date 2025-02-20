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

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_eip.id
  //NAT gateway should be always in public subnet. when in public subnet,the requests comming from db or backend , it can send to internet
  subnet_id     = aws_subnet.public[0].id

  tags = merge( 
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = local.resource_name
    }
  )
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # Actually we don't need IGW to create NAT GW. All we need is one elastic iP and public subnet to create NAT Gateway. But if IGW is not there it will not work because the traffic which comes to public subnet is from IGW. if you simply create NAT GW without IGW then its of no use hence explicitly NAT is dependent on IGW. TF will ensure IGW exists then it will create NAT GW
  depends_on = [aws_internet_gateway.main]
}