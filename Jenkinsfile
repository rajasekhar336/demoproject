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
                    def ecrUrl = 'https://471112907684.dkr.ecr.ap-south-1.amazonaws.com'
                    def dockerImage = 'rajack'
                    

                    docker.withRegistry(ecrUrl, 'ecr:ap-south-1:AWS_CRED') {
                        // Tag the image with a timestamp
                        docker.image(dockerImage).tag

                        // Push the tagged image
                        docker.image("${ecrUrl}/${dockerImage}:").push()

                        // Tag the image as 'latest'
                        docker.image(dockerImage).tag("latest")

                        // Push the 'latest' tagged image
                        docker.image("${ecrUrl}/${dockerImage}:latest").push()
                    }
                }
            }
        }
    }
}
