pipeline {
    agent any
    stages {
        stage('SCM') {
            steps {
                // Get some code from a GitHub repository
                git url: 'https://github.com/karthikselva17/Demophp.git', branch: 'main'
                }          
        }
        stage('SonarQube Code Scan') {
        environment {
            scannerHome = tool 'sonar-scanner'
          }
            steps {
            withSonarQubeEnv('sonarserver') {
            sh "${scannerHome}/bin/sonar-scanner"
            }
        }  
      }
       
      stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Build') {
            steps {
                sh "docker build -t Demoapp . "
             //   sh "docker tag nodejsapp:latest 660656678331.dkr.ecr.us-east-1.amazonaws.com/node:latest"
                }
            }
   
   }
}