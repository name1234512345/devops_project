pipeline {
  agent any

    environment {
        DOCKERHUB_USERNAME = 'kateilievsk123'
        DOCKERHUB_REPO = 'kateilievsk123'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        PROJECT_DIR = "${WORKSPACE}"
        KUBE_NAMESPACE = "default"
        KUBECONFIG = credentials('kubernetes-secret')
            DOCKER_HOST = sh(script: "minikube docker-env --shell=bash | grep DOCKER_HOST | cut -d '=' -f 2 | tr -d '\"'", returnStdout: true).trim()
            DOCKER_TLS_VERIFY = sh(script: "minikube docker-env --shell=bash | grep DOCKER_TLS_VERIFY | cut -d '=' -f 2 | tr -d '\"'", returnStdout: true).trim()
            DOCKER_CERT_PATH = sh(script: "minikube docker-env --shell=bash | grep DOCKER_CERT_PATH | cut -d '=' -f 2 | tr -d '\"'", returnStdout: true).trim()

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
