terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.35"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Creating a new Key Pair
resource "aws_key_pair" "main" {

  # Name of the Key
  key_name = "EPAM_Final_Project_key"

  # Adding the SSH public key to authorized keys!
  public_key = file("~/.ssh/id_rsa.pub")

}