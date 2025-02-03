pipeline {
    agent any

    stages {
        stage('Check Docker Installation') {
            steps {
                script {
                    echo "Checking Docker version..."
                }
                sh 'docker --version'  // Check Docker version
                sh 'docker info'       // Get detailed Docker info
                sh 'docker ps'         // List running Docker containers
        
            }
        }
    }
}
