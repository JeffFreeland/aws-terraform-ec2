terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_key_pair" "ubuntu" {
  key_name = "ubuntu"
  public_key = file("terraform.pub")
}

resource "aws_security_group" "ubuntu" {
  name = "ubuntu-security-group"
  description = "Allow SSH traffic"

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformSecurityGroup"
  }

}

resource "aws_instance" "app_server" {
  ami           = "ami-03d5c68bab01f3496"
  instance_type = "t2.micro"

  key_name = "ubuntu"

  tags = {
    Name = "ExampleAppServerInstance"
  }

  vpc_security_group_ids = [
    aws_security_group.ubuntu.id
  ]

  root_block_device {
    volume_size = "10"
    tags = {
      Name = "ExampleRootBlockDevice"
      ExtraTagName = "ExtraTagValue"
    }
  }
}

# This was in the tutorial, but didn't appear to be necessary in order to connect? I still got an ipv4 address, and an aws dns name. 
# Probably my problem before was not the EIP, but the key pair. 
# resource "aws_eip" "ubuntu" {
#  vpc = true
#  instance = aws_instance.app_server.id
#}