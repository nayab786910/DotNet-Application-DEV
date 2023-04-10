pipeline {
    agent any
    environment { 
                  registry1 = "519852036875.dkr.ecr.us-east-2.amazonaws.com/cloudjournee:${env.BUILD_NUMBER}"
                }

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Abhilash-1201/DotNet-Application-DEV.git' 
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

 //Build the docker image to store in to ECR
        stage('Building docker image for dev')  {
         steps{
           script{
               dockerImage = docker.build registry1 
           }
         }
       }
        // Push the docker image in to dev ECR
       stage('Pushing docker image to Dev-ECR') {
        steps{  
         script {
                sh 'docker logout'
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 519852036875.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker push ${registry1}'
               }
           }
      
        }  
    }
}
