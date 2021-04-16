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

variable "worker_nodes_num" {
  description = "Number of Worker nodes in Kubernetes cluster"
  type        = number
  default     = 1
}