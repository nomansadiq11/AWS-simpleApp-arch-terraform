# Creating a Security Group for WordPress
resource "aws_security_group" "QMS-web-sg" {

  depends_on = [
    aws_vpc.QMSVPC,
    aws_subnet.PrivateSubnet,
    aws_subnet.PublicSubnet
  ]

  description = "HTTP, PING, SSH"

  # Name of the security Group!
  name = "QMS-web-sg"

  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.QMSVPC.id

  # Created an inbound rule for webserver access!
  ingress {
    description = "HTTP for webserver"
    from_port   = 80
    to_port     = 80

    # Here adding tcp instead of http, because http in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for ping
  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22

    # Here adding tcp instead of ssh, because ssh in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outward Network Traffic for the WordPress
  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
    Name        = "QMS-Web-Server-sg"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }

}


# Creating security group for DB
resource "aws_security_group" "QMS-db-sg" {

  depends_on = [
    aws_vpc.QMSVPC,
    aws_subnet.PrivateSubnet,
    aws_subnet.PublicSubnet
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name        = "QMS-db-sg"
  vpc_id      = aws_vpc.QMSVPC.id

  # Created an inbound rule for MySQL
  # ingress {
  #   description     = "MySQL Access"
  #   from_port       = 3306
  #   to_port         = 3306
  #   protocol        = "tcp"
  #   security_groups = [aws_security_group.WS-SG.id]
  # }

  # egress {
  #   description = "output from MySQL"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

tags = {
    Name        = "QMS-db-server-sg"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }

}


# Creating security group for Bastion Host/Jump Box
resource "aws_security_group" "QMS-BH-SG" {

  depends_on = [
    aws_vpc.QMSVPC,
    aws_subnet.PrivateSubnet,
    aws_subnet.PublicSubnet
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name        = "bastion-host-sg"
  vpc_id      = aws_vpc.QMSVPC.id

  # Created an inbound rule for Bastion Host SSH
  ingress {
    description = "Bastion Host SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "QMS-bastion-host-sg"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }


}

# Creating security group for MySQL Bastion Host Access
resource "aws_security_group" "DB-SG-SSH" {

  depends_on = [
    aws_vpc.QMSVPC,
    aws_subnet.PrivateSubnet,
    aws_subnet.PublicSubnet,
    aws_security_group.QMS-BH-SG
  ]


  description = "MySQL Bastion host access for updates!"
  name        = "mysql-sg-bastion-host"
  vpc_id      = aws_vpc.QMSVPC.id

  # Created an inbound rule for MySQL Bastion Host
  ingress {
    description     = "Bastion Host SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.QMS-BH-SG.id]
  }

  egress {
    description = "output from MySQL BH"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "QMS-db-ssh-sg"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}