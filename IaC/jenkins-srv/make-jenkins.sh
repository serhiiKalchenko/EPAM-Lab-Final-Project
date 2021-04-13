#!/bin/bash
set -e

terraform fmt
terraform validate

# Create instance
terraform apply --auto-approve

# Configure instance
ansible-playbook setup-jenkins.yml

# Print output info
terraform output
