# EPAM-Lab-Final-Project
## CI/CD Multibranch Jenkins Pipeline to Kubernetes cluster
This Pipeline build Java application [`spring-petclinic`](https://github.com/spring-projects/spring-petclinic) and deploy it into Kubernetes cluster.

### Technologies:
- **Docker**: container engine
- **Jenkins**: CI/CD tool
- **Maven**: build automation tool (Java)
- **Terraform**: infrastructure provision tool
- **Ansible**: infrastructure configuration tool
- **Kubernetes**: container orchestration tool

### Objects:
- Jenkins server with Ansible on board
- Kubernetes cluster (kubeadm)

### Stages of Pipeline
- `Show Parameters`
- `Build App`
- `Build Docker Image`
- `Push Docker Image`
- `Deploy to Kubernetes`

### Features
- All infrastructure is started with one single command/script (Terraform and Ansible)
- Dynamic inventory (plugin)
- Pipeline has parameters

### Description of the Project
Project consists of two parts:
1. Jenkins Pipeline
    - `Jenkinsfile`
        - `groovy.script`
    - `Dockerfile`
    - `deploy_to_kubernetes.yml`
2. Infrastructure as a Code (`IaC/` folder)
    - `jenkins-srv`
        - files to run single Jenkins server
        - network: default
    - `kube-cluster`
        - files to create single Kubernetes cluster
        - network: default
    - `all-in-one`
        - files to run all together
        - network: own VPC, subnet, gateway, route table etc.
