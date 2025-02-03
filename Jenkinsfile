pipeline {
    agent {
        docker {
            image 'maven:3.8.6-openjdk-11'
            args '--user root'
        }
    }

    stages {
        stage('Check Docker') {
            steps {
                sh 'docker --version'     
                sh 'docker ps'            // List running containers
            }
        }
    }
}
