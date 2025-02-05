pipeline {
    agent any

    environment {
          imageName = "spring_app"
          DOCKER_CREDENTIALS_ID = "nexus"
          registry = "http://nexus-nexus-1:8085/repository/ci_cd_repository/"
          dockerImage = ''
          NEXUS_URL = 'http://nexus-nexus-1:8085'
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
                 dockerImage = docker.build imageName
               }
             }
           }

                 stage('Login to Nexus') {
                       steps {
                           script {
                               withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'admin', passwordVariable: 'admin')]) {
                                   sh "docker login -u admin -p admin ${NEXUS_URL}"
                               }
                           }
                       }
                   }

                   stage('Push Image to Nexus') {
                       steps {
                           script {
                               sh "docker push ${NEXUS_URL}/${NEXUS_REPO}/${IMAGE_NAME}:latest"
                           }
                       }
                   }
}
}