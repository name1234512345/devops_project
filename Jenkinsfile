pipeline {
    agent any

    environment {
          imageName = "spring_app"
          registryCredentials = "nexus"
          registry = "host.docker.internal:8081"
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
                        docker.withRegistry( 'http://'+registry, registryCredentials ) {
                        dockerImage.push('latest')
                     }
                   }
                 }

    }
}
}