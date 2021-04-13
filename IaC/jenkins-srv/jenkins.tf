terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.35"
    }
  }
}

# Installing Jenkins server with Java, Maven and Docker
provider "aws" {
  region = "us-west-1"
}

# Creating a new Key Pair
resource "aws_key_pair" "main" {

  # Name of the Key
  key_name = "EPAM_Final_Project_key"

  # Adding the SSH public key to authorized keys!
  public_key = file("~/.ssh/id_rsa.pub")

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


resource "aws_security_group" "jenkins" {
  name        = "Jenkins"
  description = "Allow ports: 22, 8080, all internal traffic"

  ingress {
    description = "22 port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["217.147.173.191/32"]
  }

  ingress {
    description = "8080 port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "217.147.173.191/32",
      "192.30.252.0/22",
      "185.199.108.0/22",
      "140.82.112.0/20"
    ]
  }

  ingress {
    description = "All internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.small"
  key_name               = "EPAM_Final_Project_key"
  vpc_security_group_ids = [aws_security_group.jenkins.id]

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${self.tags.Name}"
    ]
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }

  tags = {
    Name    = "jenkins"
    Srv     = "jenkins"
    Role    = "jenkins_control"
    Project = "EPAM_Final_project"
  }
}

output "jenkins" {
  description = "public IP address of jenkins"
  value       = aws_instance.jenkins.public_ip
}
