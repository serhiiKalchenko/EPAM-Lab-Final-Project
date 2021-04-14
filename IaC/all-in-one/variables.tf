# Initial 

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "project_name" {
  description = "Name of the project. Used in resource names and tags."
  type        = string
  default     = "EPAM_Final_project"
}


# Network

variable "vpc" {
  description = "VPC network"
  type        = string
  default     = "10.10.0.0/16"
}

variable "vpc_subnet" {
  description = "subnet of VPC"
  type        = string
  default     = "10.10.10.0/24"
}

variable "vpc_subnet_list" {
  description = "List of subnets"
  type        = list(string)
  default     = ["10.10.10.0/24"]
}

variable "ip_white_list" {
  description = "Allowed IP addresses"
  type        = list(string)
  default = [
    "217.147.173.191/32",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20"
  ]
}

variable "my_ip_list" {
  description = "List of my IPs"
  type        = list(string)
  default     = ["217.147.173.191/32"]
}


# Instances (servers, nodes)

variable "jenkins_private_ip" {
  description = "private IP of Jenkins server"
  type        = string
  default     = "10.10.10.10"
}

variable "kube_control_private_ip" {
  description = "private IP of Kube Control node"
  type        = string
  default     = "10.10.10.11"
}

variable "worker_nodes_num" {
  description = "Number of Worker nodes in Kubernetes cluster"
  type        = number
  default     = 1
}