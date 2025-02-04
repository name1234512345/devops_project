pipeline {

    agent any

    environment {
        imageName = "spring_app"
        registryCredentials = "nexus_credentials"
        registry = "http://localhost:8081/repository/ci_cd_project_repository/"
        dockerImage = ''
    }

    stages {
        stage('Code checkout') {
            steps {
                            checkout scm

        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imageName
        }
      }
    }

    // Uploading Docker images into Nexus Registry
    stage('Uploading to Nexus') {
     steps{
         script {
             docker.withRegistry( registry, registryCredentials ) {
             dockerImage.push('latest')
          }
        }
      }
    }

    // Stopping Docker containers for cleaner Docker run
    stage('stop previous containers') {
         steps {
            sh 'docker ps -f name=myphpcontainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=myphpcontainer -q | xargs -r docker container rm'
         }
       }

    stage('Docker Run') {
       steps{
         script {
                sh 'docker run -d -p 80:80 --rm --name myphpcontainer ' + registry + imageName
            }
         }
      }
    }
}