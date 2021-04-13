# Provision instances for Kubernetes cluster

resource "aws_security_group" "kube_cluster" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main
  ]

  vpc_id = aws_vpc.main.id

  name        = "Kube-cluster"
  description = "Allow ports: 22, 8080, all internal traffic"

  # Inbound rule for ping
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
    cidr_blocks = ["217.147.173.191/32"]
  }

  ingress {
    description = "All internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.10.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Kube-cluster"
  }
}

resource "aws_instance" "kube_control" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main,
    aws_security_group.jenkins
  ]

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = "EPAM_Final_Project_key"

  subnet_id  = aws_subnet.main.id
  private_ip = "10.10.10.20"

  vpc_security_group_ids = [aws_security_group.kube_cluster.id]

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
    Name    = "kube_control"
    Srv     = "kubernetes"
    Role    = "control"
    Project = "EPAM_Final_project"
  }
}

resource "aws_instance" "kube_worker_1" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main,
    aws_security_group.jenkins
  ]

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = "EPAM_Final_Project_key"

  subnet_id  = aws_subnet.main.id
  private_ip = "10.10.10.21"

  vpc_security_group_ids = [aws_security_group.kube_cluster.id]

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
    Name    = "kube_worker_1"
    Srv     = "kubernetes"
    Role    = "worker"
    Project = "EPAM_Final_project"
  }
}

resource "aws_instance" "kube_worker_2" {

  depends_on = [
    aws_vpc.main,
    aws_subnet.main,
    aws_security_group.jenkins
  ]

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = "EPAM_Final_Project_key"

  subnet_id  = aws_subnet.main.id
  private_ip = "10.10.10.22"

  vpc_security_group_ids = [aws_security_group.kube_cluster.id]

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
    Name    = "kube_worker_2"
    Srv     = "kubernetes"
    Role    = "worker"
    Project = "EPAM_Final_project"
  }
}



