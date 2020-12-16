# Creating an AWS instance for the Bastion Host, It should be launched in the public Subnet!
resource "aws_instance" "WebServer" {

  ami           = "ami-04d29b6f966df1537"
  instance_type = "t3.2xlarge"
  subnet_id     = aws_subnet.PrivateSubnet.id

  # Keyname and security group are obtained from the reference of their instances created above!
  key_name = "devopstest"

  # Security group ID's
  vpc_security_group_ids = [aws_security_group.QMS-web-sg.id]
  tags = {
    Name        = "QMS-Web-Server"
    Environment = "${var.tagEnvironment}"
    Project     = "${var.tagProject}"
  }
}