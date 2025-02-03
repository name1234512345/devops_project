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

        stage('Build & Test') {
            steps {
                script {
                    sh 'mvn clean package'
                    sh 'docker-compose up -d'
                    sh 'mvn verify' // Run integration tests
                    sh 'docker-compose down'
                }
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

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down' // Stop previous containers
                    sh 'docker-compose up -d' // Start new deployment
                }
            }
        }
    }

    post {
        always {
            sh 'docker-compose down -v'
        }
    }
}
