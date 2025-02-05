pipeline {
    agent any

    environment {
          IMAGE_NAME = "spring_app"
          DOCKER_CREDENTIALS_ID = "nexus"
          registry = "https://83f0-31-11-111-199.ngrok-free.app/repository/ci_cd_repository/"
          dockerImage = ''
          NEXUS_URL = 'https://83f0-31-11-111-199.ngrok-free.app'
          NEXUS_REPO = 'ci_cd_repository'

      }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }



           // Building Docker images
           stage('Building image') {
             steps{
               script {
                 dockerImage = docker.build IMAGE_NAME
               }
             }
           }

                 stage('Login to Nexus') {
                       steps {
                           script {
                               withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                                                   sh "docker login -u ${NEXUS_USER} -p ${NEXUS_PASS} ${NEXUS_URL}"
                               }
                           }
                       }
                   }

                   stage('Push Image to Nexus') {
                       steps {
                           script {
                               sh "docker push ${NEXUS_URL}/${IMAGE_NAME}:latest"
                           }
                       }
                   }
}
}