pipeline {
    agent any

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
    }
}
