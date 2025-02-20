resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1: 0
  // The ID of the requester VPC.
   vpc_id        = aws_vpc.main.id
  //The ID of the acceptor VPC or the ID of the target VPC with which you are creating the VPC Peering Connection.
  peer_vpc_id   = local.default_vpc_id
// Accept the peering (both VPCs need to be in the same AWS account and region for auto_accept = true).
  auto_accept = true
    tags = merge(
        var.common_tags,
        var.vpc_peering_tags,
    {
    Name = "${local.resource_name}-default"
  }
    )
}

// Peering at subnets level
// giving access to public subnet VPC peering. It's our choice/requirement to give access to private and db subnets
resource "aws_route" "public_subnet_peering" {
  count = var.is_peering_required ? 1: 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = local.default_vpc_cidr //aceptor CIDR - destination
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id // VPC Peering ID - target
}

resource "aws_route" "private_subnet_peering" {
  count = var.is_peering_required ? 1: 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = local.default_vpc_cidr //aceptor CIDR - destination
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id // VPC Peering ID - target
}


resource "aws_route" "database_subnet_peering" {
  count = var.is_peering_required ? 1: 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = local.default_vpc_cidr //aceptor CIDR - destination
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id // VPC Peering ID - target
}


//--------------------------------------------------------------------------------------

// Peering at subnets level has to be done at default vpc route table.

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1: 0
  route_table_id            = data.aws_route_table.default-rt.route_table_id
  destination_cidr_block    = var.vpc_cidr //requetor CIDR - destination
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id // VPC Peering ID - target
}
