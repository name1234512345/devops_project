pipeline {
    agent any

    environment {
          imageName = "spring_app"
          registryCredentials = "nexus"
          registry = "http://nexus-nexus-1:8085/repository/ci_cd_repository/"
          dockerImage = ''
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

               stage('Uploading to Nexus') {
                steps{
                    script {
                        docker.withRegistry( registry, registryCredentials ) {
                        dockerImage.push('latest')
                     }
                   }
                 }

    }
}
}