#!/bin/bash
set -e
# Installing all necessary roles for Ansible playbooks
# all roles and community will be installed in current dir

ansible-galaxy install geerlingguy.java --roles-path ./roles
ansible-galaxy install gantsign.maven --roles-path ./roles
ansible-galaxy install geerlingguy.jenkins --roles-path ./roles

# Install collections

# dynamic inventory
ansible-galaxy collection install amazon.aws -p ./collections

# for deploy in Kubernetes cluster
ansible-galaxy collection install kubernetes.core -p ./collections