pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "serhiikalchenko/spring-petclinic-image"
        REGISTRY = "registry.hub.docker.com"
    }
    stages {
        
        stage('Build App') {
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
                    app = docker.build("$DOCKER_IMAGE_NAME")       
                }
            }
        }
        /*
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
        
        stage('Deploy To Kubernetes') {
            when {
                branch 'main'
            }
            steps {
                script{              
                    sh "ansible-playbook deploy_to_kubernetes.yml --extra-vars \"DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME} BUILD_NUMBER=${BUILD_NUMBER}\""
                }
            }
        }
        */
    }
    /*
    post {
        cleanup {
            sh "docker rmi ${REGISTRY}/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        }
    }
    */
}
