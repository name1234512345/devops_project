pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'kateilievsk123'
        DOCKERHUB_REPO = 'kateilievsk123'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        PROJECT_DIR = "${WORKSPACE}"
        KUBECONFIG = credentials('kubernetes-secret')
        KUBE_NAMESPACE = "default"
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
                        docker push ${DOCKERHUB_REPO}/${service}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy to docker  and Start Containers') {
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
            stage('Run Maven Tests') {
                            steps {

                                script {
                                   sh "docker exec service1 mvn test"
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


stage('Deploy to Kubernetes') {

       steps {
           sh 'kubectl apply -f k8s/service1-deployment.yaml --validate=false'
           sh 'kubectl apply -f k8s/service1.yaml --validate=false'
            sh 'kubectl apply -f k8s/service2-deployment.yaml --validate=false'
            sh 'kubectl apply -f k8s/service2.yaml --validate=false'
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
