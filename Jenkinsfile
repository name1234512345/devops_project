pipeline {
  agent {label 'docker-agent'}

    environment {
        DOCKERHUB_USERNAME = 'kateilievsk123'
        DOCKERHUB_REPO = 'kateilievsk123'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        PROJECT_DIR = "${WORKSPACE}"
        KUBE_NAMESPACE = "default"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

  stage('Check Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }

          stage('Check Docker compose') {
                    steps {
                        script {
                            sh 'docker compose --version'
                        }
                    }
                }


        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker compose build'
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
                        """
                    }
                }
            }
        }

        stage('Deploy and Start Containers') {
            steps {
                script {
                    sh "docker compose up -d"
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





    }



    post {
        always {
            script {
                sh "docker compose down"
            }
        }
    }
}
