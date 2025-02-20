// ---------- Public subnet ---------------------
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  //availability_zone is optional but we need to give to specify with subnet belong to a specific AZ.else terraform will it take some random thing on its own
  //availability_zone = data.aws_availability_zones.available.names[count.index]
  availability_zone =local.az_names[count.index]

  //since this is public subnet, the instances launching under this subnet should be assigned with public IP address
  // hence this argument made true
  map_public_ip_on_launch = true

    #expense-dev-public-us-east-1a
    tags = merge(
    var.common_tags,
    var.public_subnet_tags,
    {
        Name = "${local.resource_name}-public-${local.az_names[count.index]}"
    }
  )

}

//------------ Private subnet ---------------------
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  //availability_zone is optional but we need to give to specify with subnet belong to a specific AZ.
  //availability_zone = data.aws_availability_zones.available.names[count.index]
  availability_zone =local.az_names[count.index]

    #expense-dev-private-us-east-1a
    tags = merge(
    var.common_tags,
    var.private_subnet_tags,
    {
        Name = "${local.resource_name}-private-${local.az_names[count.index]}"
    }
  )

}

//------------ Database subnet ---------------------

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  //availability_zone is optional but we need to give to specify with subnet belong to a specific AZ.
  //availability_zone = data.aws_availability_zones.available.names[count.index]
  availability_zone =local.az_names[count.index]

    #expense-dev-database-us-east-1a
    tags = merge(
    var.common_tags,
    var.database_subnet_tags,
    {
        Name = "${local.resource_name}-database-${local.az_names[count.index]}"
    }
  )

}