#!/bin/bash
set -e

terraform fmt
terraform validate

# Create instances
terraform apply --auto-approve

# Make a Kubernetes cluster
ansible-playbook setup-kube.yml

# Print instance info
terraform output