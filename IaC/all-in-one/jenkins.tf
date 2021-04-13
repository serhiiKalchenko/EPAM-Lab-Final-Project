#Create Security Group for Jenkins instance
resource "aws_security_group" "jenkins" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main
  ]

  vpc_id = aws_vpc.main.id

  name        = "Jenkins"
  description = "Allow ports: 22, 8080"

  # Created an inbound rule for ping
  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["217.147.173.191/32"]
  }

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
    cidr_blocks = ["10.10.10.0/24"]
  }

  # any port from inside to outside allowed
  egress {
    description = "All ports any protocol"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins"
  }
}



resource "aws_instance" "jenkins" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main,
    aws_security_group.jenkins
  ]

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.small"
  key_name               = "EPAM_Final_Project_key"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.jenkins.id]

  private_ip = "10.10.10.10"

  # Set hostnames
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${self.tags.Name}"
    ]
    connection {
      host        = aws_instance.jenkins.public_ip
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