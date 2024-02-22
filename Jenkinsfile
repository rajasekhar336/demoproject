pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'clone'
            }
        }
        stage('Docker build') {
            steps {
                script {
                    app =  docker.build('rajack')
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Empty'
            }
        }
        stage('Docker push to ECR') {
            steps {
                script {
                    docker.withRegistry('https://471112907684.dkr.ecr.ap-south-1.amazonaws.com/rajack', 'ecr:ap-south-1:AWS_CRED') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest") 
                    }
                }
            }
        }
        stage('Integrate Jenkins with EKS Cluster and Deploy') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'demo1', contextName: '', credentialsId: 'SECRETE_TOKEN', namespace: 'default', serverUrl: 'https://42B1C5C5791CAE749477F598FF4F39D0.gr7.ap-south-1.eks.amazonaws.com']]) {
                sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
