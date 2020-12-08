resource "aws_vpc" "QMSVPC" {
  cidr_block       = "172.11.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name        = "QMS-VPC"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}


# Private Subnet 
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.QMSVPC.id
  cidr_block = "172.11.0.0/24"

  tags = {
    Name        = "QMS-Private-Subnet"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}



# Public Subnet 
resource "aws_subnet" "PublicSubnet" {
  vpc_id                  = aws_vpc.QMSVPC.id
  cidr_block              = "172.11.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "QMS-Public-Subnet"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}