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
                    def ecrCredentials = 'AWS_CRED'
                    def ecrUrl = 'https://471112907684.dkr.ecr.ap-south-1.amazonaws.com/rajack'
                    def dockerImage = 'your_image_name'
                    def buildNumber = "${env.BUILD_NUMBER}"

                    docker.withRegistry(ecrUrl, ecrCredentials) {
                        // Tag the image with build number
                    docker.image(dockerImage).tag("${buildNumber}")

                        // Push the tagged image
                    docker.image("${ecrUrl}/${dockerImage}:${buildNumber}").push()

                        // Tag the image as 'latest'
                    docker.image(dockerImage).tag('latest')

                        // Push the 'latest' tagged image
                    docker.image("${ecrUrl}/${dockerImage}:latest").push()
                    }
                }
            }
        }
    }
}
