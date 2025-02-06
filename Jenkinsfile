pipeline {
    agent any

    environment {
          IMAGE_NAME = "spring_app"
          DOCKER_CREDENTIALS_ID = "nexus"
          registry = "https://83f0-31-11-111-199.ngrok-free.app/repository/ci_cd_repository/"
          dockerImage = ''
          NEXUS_URL = 'https://83f0-31-11-111-199.ngrok-free.app'
          NEXUS_URL1 = '83f0-31-11-111-199.ngrok-free.app'
          NEXUS_REPO = 'ci_cd_repository'
          IMAGE_TAG = "latest"


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
                   docker.build("${NEXUS_URL1}/${IMAGE_NAME}:${IMAGE_TAG}")
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
                               docker.image("${NEXUS_URL1}/${IMAGE_NAME}:${IMAGE_TAG}").push()
                           }
                       }
                   }
}
}