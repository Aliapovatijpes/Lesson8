terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}

provider "aws" {
  access_key = "${var.ACCESS_KEY}"
  secret_key = "${var.SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

resource "aws_instance" "PHPMyAdminInstance" {
  ami           = "ami-0a5b5c0ea66ec560d"
  instance_type = "t2.micro"
  tags = {
    "Name" = "PHPMyAdminInstance"
  }
  subnet_id = "${aws_subnet.intern_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.intern_securitygroup.id}"]
  key_name = "KeypairForPHPMyAdmin"
  user_data = file("user_data.sh")
}