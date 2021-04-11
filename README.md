# EPAM-Lab-Final-Project
## CI/CD Jenkins Multibranch Pipeline to Kubernetes cluster
This pipeline build Java application and deploy it into Kubernetes cluster.

### Technologies:
- Jenkins: CI/CD tool
- Terraform: provision infrastructure
- Ansible: configuration infrastructure
- Kubernetes: container orchestration tool
- Docker: container engine

### Objects:
- Jenkins server with Ansible on board
- Kubernetes cluster (kubeadm)

### Stages of Pipeline
- 'Show Parameters'
- 'Build App'
- 'Build Docker Image'
- 'Push Docker Image'
- 'Deploy to Kubernetes'

#### Features
- All infrastructure is started with one single command/script (Terraform and Ansible)
- Dynamic inventory (plugin)
- Pipeline has parameters
