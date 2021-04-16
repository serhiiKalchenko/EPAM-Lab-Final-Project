terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.35"
    }
  }
}

module "infra_network" {
  source = "github.com/serhiiKalchenko/terraform/modules/infra_network"

  aws_region              = var.aws_region
  project_name            = var.project_name
  vpc                     = var.vpc
  vpc_subnet              = var.vpc_subnet
  vpc_subnet_list         = var.vpc_subnet_list
  ip_white_list           = var.ip_white_list
  my_ip_list              = var.my_ip_list
  jenkins_instance_type   = var.jenkins_instance_type
  kube_instance_type      = var.kube_instance_type
  jenkins_private_ip      = var.jenkins_private_ip
  kube_control_private_ip = var.kube_control_private_ip
  worker_nodes_num        = var.worker_nodes_num
}

output "jenkins" {
  value = module.infra_network.jenkins_public_ip
}

output "kube_control" {
  value = module.infra_network.kube_control_public_ip
}

output "kube_worker" {
  value = module.infra_network.kube_worker_public_ip
}