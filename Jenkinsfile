pipeline {
    agent { docker { image 'alpine' } }
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }
    }
}
