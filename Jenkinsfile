pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'kateilievsk123'
        DOCKERHUB_REPO = 'kateilievsk123'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'docker_hub_secret_text'
        PROJECT_DIR = "${WORKSPACE}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }


        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }


        stage('Login to Docker Hub') {
            steps {
                script {
                     withCredentials([string(credentialsId: DOCKER_CREDENTIALS_ID, variable: 'DOCKER_PASSWORD')]) {
                                                      sh "echo $DOCKER_PASSWORD | docker login -u kateilievsk123 -p Mesledat3godini555!"
                                                  }
                }
            }
        }

        stage('Tag and Push Docker Images') {
            steps {
                script {
                    def services = ['service1', 'service2'] // List services from docker-compose.yml
                    for (service in services) {
                        sh """
                        docker tag ${service}:latest ${DOCKERHUB_REPO}/${service}:${IMAGE_TAG}
                        docker push ${DOCKERHUB_REPO}/${service}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy and Start Containers') {
            steps {
                script {
                    sh "docker-compose up -d"
                }
            }
        }

         stage('Check Container Logs') {
                    steps {
                        script {
                            sh 'docker logs service1'
                        }
                    }
                }

          stage('Check Running Containers') {
                    steps {
                        script {
                            sh 'docker ps'
                        }
                    }
                }

            stage('Run Maven Tests') {
                            steps {
                                // Use a Docker Maven container to run the tests
                                script {
                                   sh "docker exec service1 mvn test"
                                }
                            }
                        }
    }



    post {
        always {
            script {
                sh "docker-compose down"
            }
        }
    }
}
