pipeline {
    agent any

    environment {
        NEXUS_REGISTRY = "http://localhost:8081/repository/ci_cd_project_repository/"
        IMAGE_NAME = "${NEXUS_REGISTRY}/spring-boot-app:latest"
        COMPOSE_FILE = "docker-compose.yaml"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t spring_app ."
                }
            }
        }

        stage('Push to Nexus Repository') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus_credentials', usernameVariable: 'admin', passwordVariable: 'admin')]) {
                        sh "echo admin | docker login ${NEXUS_REGISTRY} -u admin --password-stdin"
                        sh "docker push spring_app"
                    }
                }
            }
        }


    post {

    }
}
