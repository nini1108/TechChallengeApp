resource "aws_route_table" "route_table" {
  vpc_id = var.route_table_vpc_id

  tags = var.tags
}
