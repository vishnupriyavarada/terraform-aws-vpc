resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
        Name = "${local.resource_name}-public"
    }
  )  
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
        Name = "${local.resource_name}-private"
    }
  )  
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
        Name = "${local.resource_name}-database"
    }
  )  
}

//------------- create routes -------------------

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0" //internet - destination
  gateway_id = aws_internet_gateway.main.id // IGW id - target
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0" //internet - destination
  nat_gateway_id = aws_nat_gateway.main.id // NAT Gateway id -target
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0" //internet - destination
  nat_gateway_id = aws_nat_gateway.main.id // NAT Gateway id -target
}

//-------------- Route table association with subnets  -------------------

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id // public subnet
  route_table_id = aws_route_table.public.id // public Routetable id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private[count.index].id // private subnet
  route_table_id = aws_route_table.private.id // public Routetable id
}
resource "aws_route_table_association" "database" {
 count = length(var.database_subnet_cidr)
  subnet_id      = aws_subnet.database[count.index].id // public subnet
  route_table_id = aws_route_table.database.id // public Routetable id
}