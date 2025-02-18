pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: kubernetes-deploy
spec:
  containers:
  - name: kubectl
    image: bitnami/kubectl:latest  // Use a kubectl container image
    command:
    - cat
    tty: true
  - name: docker
    image: docker:19.03.12  // Use Docker container for building the image
    command:
    - cat
    tty: true
'''
        }
    }


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

            stage('Run Maven Tests') {
                            steps {
                                // Use a Docker Maven container to run the tests
                                script {
                                   sh "docker exec service1 mvn test"
                                }
                            }
                        }

                          stage('Deploy to Kubernetes') {
                                 steps {
                                     sh 'kubectl apply -f k8s/deployment.yaml'
                                     sh 'kubectl apply -f k8s/service.yaml'
                                 }
                             }

                             stage('Verify Deployment') {
                                 steps {
                                     sh 'kubectl get pods -n $KUBE_NAMESPACE'
                                     sh 'kubectl get svc -n $KUBE_NAMESPACE'
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
