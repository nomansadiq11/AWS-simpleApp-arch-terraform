resource "aws_internet_gateway" "QMS_internet_gateway" {
  depends_on = [
    aws_vpc.QMSVPC,
  ]

  vpc_id = aws_vpc.QMSVPC.id

  tags = {
    Name = "internet-gateway"
  }
}