resource "aws_route_table" "IG_route_table" {
  depends_on = [
    aws_vpc.QMSVPC,
    aws_internet_gateway.QMS_IG,
  ]

  vpc_id = aws_vpc.QMSVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.QMS_IG.id
  }

  tags = {
    Name = "IG-route-table"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on = [
    aws_subnet.PublicSubnet,
    aws_route_table.IG_route_table,
  ]
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.IG_route_table.id
}