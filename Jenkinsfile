pipeline {
     agent {
                       docker {
                         image 'node:7-alpine'
                         args '--name docker-node' // list any args
                       }
                     }


    environment {
        NEXUS_REGISTRY = "http://localhost:8081/repository/ci_cd_project_repository/"
        IMAGE_NAME = "${NEXUS_REGISTRY}/spring-boot-app:latest"
        COMPOSE_FILE = "docker-compose.yaml"
    }

    stages {
        stage('Docker node test') {
          agent {
            docker {
              image 'node:7-alpine'
              args '--name docker-node' // list any args
            }
          }
          steps {
            // Steps run in node:7-alpine docker container on docker agent
            sh 'node --version'
          }
        }

        stage('Docker maven test') {
          agent {
            docker {
              image 'maven:3-alpine'
            }
          }
          steps {
            // Steps run in maven:3-alpine docker container on docker agent
            sh 'mvn --version'
          }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                script {
                    sh 'docker-compose up -d'
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
