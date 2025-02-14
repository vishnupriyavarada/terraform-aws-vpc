resource "aws_vpc_peering_connection" "expense-dev-default" {
  count = var.is_peering_required ? 1: 0
  // The ID of the requester VPC.
   vpc_id        = aws_vpc.main.id
  //The ID of the acceptor VPC or the ID of the target VPC with which you are creating the VPC Peering Connection.
  peer_vpc_id   = local.default_vpc_id
// Accept the peering (both VPCs need to be in the same AWS account and region).
  auto_accept = true
    tags = merge(
        var.common_tags,
        var.vpc_peering_tags,
    {
    Name = "${local.resource_name}-default"
  }
    )
}