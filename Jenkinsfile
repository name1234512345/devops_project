pipeline {
     agent {
         kubernetes {
             label 'my-pod-label'
             defaultContainer 'jnlp'
             yaml '''
                 apiVersion: v1
                 kind: Pod
                 metadata:
                   name: my-pod
                   labels:
                     my-label: my-pod-label
                 spec:
                   containers:
                     - name: jnlp
                       image: jenkins/inbound-agent:latest
                       args: ['$(JENKINS_SECRET)', '$(JENKINS_NAME)', '$(JENKINS_URL)']
                     - name: docker
                       image: docker:19.03.12
                       command:
                         - cat
                       tty: true
                     - name: kubectl
                       image: bitnami/kubectl:latest
                       command:
                         - cat
                       tty: true
             '''
         }
     }




    stages {

    }




}
