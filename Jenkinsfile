pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "serhiikalchenko/spring-petclinic-image"
    }

    parameters{
        string(name: 'REGISTRY', defaultValue: 'registry.hub.docker.com', description: 'Choose the Registry')
        choice(name: 'CREDS_ID', choices: ['dockerhub_creds', 'gitlab_creds'], description: 'Choose the credential ID for Registry')
        booleanParam(name: 'BUILD_APP', defaultValue: false, description: "Should we run the 'Build App' stage?")
    }

    stages {
        
        stage('Show Parameters') {
            steps {
                script {
                    def groovy
                    groovy = load ('groovy.script')
                    groovy.showParams()
                }
            }
        }
        
        stage('Build App') {
            when {
                expression {
                    params.BUILD_APP == true
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
                    docker.withRegistry("https://${params.REGISTRY}", "${params.CREDS_ID}") {
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
