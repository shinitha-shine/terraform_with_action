provider "aws" {}
variable "project_name" {
  description = "your project name"

  default = "zomato"
}


variable "project_environment" {
  description = "project environment"

  default = "prod"
}
resource "aws_security_group" "webserver" {
  name_prefix = "${var.project_name}-${var.project_environment}-webserver"
  description = "allow ssh,http from myip"

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_instance" "webserver" {

  ami                    = "ami-06ca3ca175f37dd66"
  instance_type          = "t2.micro"
  key_name               = "testbuilder"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data              = file("setup.sh")
  tags = {

    Name    = "${var.project_name}-${var.project_environment}-webserver"
    project = var.project_name
    env     = var.project_environment
  }
}
