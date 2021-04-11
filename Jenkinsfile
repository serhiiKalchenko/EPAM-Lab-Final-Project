pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "serhiikalchenko/spring-petclinic-image"
    }

    parameters{
        string(name: 'REGISTRY', defaultValue: 'registry.hub.docker.com', description: 'Choose the Registry for images')
        choice(name: 'BUILD_ID', choices: ['latest', '1', '5', '10'], description: 'Version to deploy on Kubernetes cluster')
        booleanParam(name: 'Build_App', defaultValue: false, description: "Should we run the 'Build App' stage?")
    }

    stages {
        
        stage('Show Parameters') {
            steps {
                echo "Build_App=${params.Build_App}"
                echo "REGISTRY=${params.REGISTRY}"
                echo "BUILD_ID=${params.BUILD_ID}"
            }
        }
        
        stage('Build App') {
            when {
                expression {
                    params.Build_App == true
                }
            }            
            steps {
                echo 'Running build automation'
                sh './mvnw package'
            }
        }
    
        stage('Build Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    app = docker.build("${params.REGISTRY}/${DOCKER_IMAGE_NAME}")       
                }
            }
        }
        
        stage('Push Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_creds') {
                        app.push("${BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            when {
                branch 'main'
            }
            steps {
                script{              
                    sh "ansible-playbook deploy_to_kubernetes.yml --extra-vars \"DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME} BUILD_NUMBER=${BUILD_NUMBER}\""
                }
            }
        }
        
    }
    
    post {
        cleanup {
            sh "docker rmi ${params.REGISTRY}/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
            sh "docker rmi ${params.REGISTRY}/${DOCKER_IMAGE_NAME}:latest"
        }
    }
    
}
