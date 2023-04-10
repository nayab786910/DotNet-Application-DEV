pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build .NET application') {
            steps {
                sh 'dotnet restore'
                sh 'dotnet build -c Release'
                sh 'dotnet publish -c Release -o publish'
                archiveArtifacts artifacts: 'publish/**', allowEmptyArchive: true
            }
        }

        stage('Build and push Docker image to ECR') {
            environment {
                ECR_REGISTRY = '519852036875.dkr.ecr.us-east-2.amazonaws.com/cloudjournee'
                IMAGE_NAME = 'cloudjournee'
                TAG = 'latest'
            }

            steps {
                sh 'echo "Building Docker image..."'
                sh 'docker build -t $ECR_REGISTRY/$IMAGE_NAME:$TAG .'

                withCredentials([[
                    credentialsId: 'my-ecr-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh 'echo "Logging in to Amazon ECR..."'
                    sh 'aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY'

                    sh 'echo "Pushing Docker image to Amazon ECR..."'
                    sh 'docker push $ECR_REGISTRY/$IMAGE_NAME:$TAG'
                }
            }
        }
    }
}
