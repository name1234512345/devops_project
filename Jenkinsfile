pipeline {
    agent any

    environment {
          IMAGE_NAME = "ci_cd"
          DOCKER_CREDENTIALS_ID = "nexus"
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



           // Building Docker images
           stage('Building image') {
             steps{
               script {
                   docker.build("${NEXUS_URL1}/${IMAGE_NAME}:${IMAGE_TAG}")
               }
             }
           }
stage('Push Docker Image to Nexus') {
steps {
script {
docker.withRegistry("https://${NEXUS_URL1}",
'nexus_credentials') {
docker.image("${NEXUS_URL1}/${IMAGE_NAME}:${IMAGE_TAG}").push()
}
}
}
}

}
}