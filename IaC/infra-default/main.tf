terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.35"
    }
  }
}

module "jenkins" {
  source = "github.com/serhiiKalchenko/terraform/modules/jenkins-srv"

  aws_region    = var.aws_region
  project_name  = var.project_name
  ip_white_list = var.ip_white_list
  my_ip_list    = var.my_ip_list
}

module "kube_cluster" {
  source = "github.com/serhiiKalchenko/terraform/modules/kube-cluster"

  aws_region       = var.aws_region
  project_name     = var.project_name
  my_ip_list       = var.my_ip_list
  worker_nodes_num = var.worker_nodes_num
}


output "jenkins" {
  value = module.jenkins.public_ip
}

output "kube_control" {
  value = module.kube_cluster.control_public_ip
}

output "kube_worker" {
  value = module.kube_cluster.worker_public_ip
}

