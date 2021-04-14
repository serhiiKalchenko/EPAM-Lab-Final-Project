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
    cidr_blocks = var.my_ip_list
  }

  ingress {
    description = "22 port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.my_ip_list
  }

  ingress {
    description = "8080 port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.my_ip_list
  }

  ingress {
    description = "All internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_subnet_list
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
  key_name      = aws_key_pair.main.key_name

  subnet_id  = aws_subnet.main.id
  private_ip = var.kube_control_private_ip

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
    Project = var.project_name
  }
}



resource "aws_instance" "kube_worker" {
  count = var.worker_nodes_num
  ami   = data.aws_ami.ubuntu.id

  subnet_id = aws_subnet.main.id

  instance_type          = "t2.medium"
  key_name               = aws_key_pair.main.key_name
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
    Name    = join("_", ["kube_worker", count.index + 1])
    Srv     = "kubernetes"
    Role    = "worker"
    Project = var.project_name
  }
}

