#!/bin/bash
set -e

terraform fmt
terraform validate

# Create instances for Kubernetes cluster
terraform apply --auto-approve

# Make a Kubernetes cluster
ansible-playbook setup-kube.yml

#Print IP addresses of instances
terraform output