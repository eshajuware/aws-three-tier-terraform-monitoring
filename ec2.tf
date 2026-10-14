#########################################
###     EC2 instance Web Tier         ###
#########################################

resource "aws_instance" "PublicWebTemplate" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = "project"
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-asg"
  }
}

#########################################
###     EC2 instance App Tier         ###
#########################################

resource "aws_instance" "private-app-template" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "project"

  tags = {
    Name = "app-asg"
  }
}
