resource "aws_internet_gateway" "QMS_IG" {
  depends_on = [
    aws_vpc.QMSVPC,
  ]

  vpc_id = aws_vpc.QMSVPC.id

  tags = {
    Name        = "QMS-Internet-Gateway"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}