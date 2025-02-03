// Jenkinsfile

pipeline {
  // "Top-level" agent is assigned to docker agents via Jenkins pipeline configuration
  agent none

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
  }
}