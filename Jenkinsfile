pipeline {
    agent any

    environment {
          IMAGE_NAME = "ci_cd"
          DOCKER_CREDENTIALS_ID = "docker_hub_secret_text"
          registry = "https://e487-31-11-101-213.ngrok-free.app/repository/ci_cd_repository/"
          dockerImage = ''
          NEXUS_URL = 'https://e487-31-11-101-213.ngrok-free.app'
          NEXUS_URL1 = 'e487-31-11-101-213.ngrok-free.app'
          NEXUS_REPO = 'ci_cd'
          IMAGE_TAG = "latest"



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
                              sh "docker build -t kateilievsk123/devops_app ."
                          }
                      }
                  }

                  stage('Login to Docker Hub') {
                      steps {
                          script {
                              withCredentials([string(credentialsId: DOCKER_CREDENTIALS_ID, variable: 'DOCKER_PASSWORD')]) {
                                  sh "echo $DOCKER_PASSWORD | docker login -u kateilievsk123 --password-stdin"
                              }
                          }
                      }
                  }

                  stage('Push to Docker Hub') {
                      steps {
                          script {
                              sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                          }
                      }
                  }
}
}