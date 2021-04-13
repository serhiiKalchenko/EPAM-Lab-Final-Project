#!/bin/bash
set -e

terraform fmt
terraform validate

terraform apply --auto-approve