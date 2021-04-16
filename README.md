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

### Features
- Infrastructure is made by Terraform in a simple manner (branch `classic-simple`) and in the form of modules (branch `main`)
- All infrastructure (`IaC/`) is started with one single command (Terraform and Ansible)
- Dynamic inventory (plugin) is used
- Pipeline has parameters and groovy script


### Description of the Project
Jenkins server run the Pipeline and with Ansible (onboard) deploy the app into Kubernetes cluster.

Project consists of two parts:
1. Jenkins Pipeline
    - `Jenkinsfile`
        - `groovy.script`
    - `Dockerfile`
    - `deploy_to_kubernetes.yml`
2. Infrastructure as a Code (`IaC/` folder)
    1. `infra-default`
        - infrastructure with default network
    2. `infra-network`
        - infrastructure with own network: VPC, subnet, gateway, route table, etc. 

### Stages of Pipeline
1. `Show Parameters`
2. `Build App`
3. `Build Docker Image`
4. `Push Docker Image`
5. `Deploy to Kubernetes`

### Plugins of Jenkins
- `Pipeline`
- `GitHub`
- `GitHub Branch Source`
- `Docker`
- `Docker Pipeline`
- `Blue Ocean`


