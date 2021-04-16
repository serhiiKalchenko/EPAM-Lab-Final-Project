#!/bin/bash
set -e

terraform fmt
terraform validate

# Create infrastructure
terraform apply --auto-approve

#Configure infrastructure:
ansible-playbook setup-all.yml

# Print IP addresses of instances
terraform output