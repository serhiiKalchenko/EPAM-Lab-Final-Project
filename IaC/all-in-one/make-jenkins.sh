#!/bin/bash
set -e

terraform fmt
terraform validate

# Create instance for Jenkins server
terraform apply --auto-approve

# Make Jenkins server
ansible-playbook setup-jenkins.yml

# Print IP addresses of instances
terraform output