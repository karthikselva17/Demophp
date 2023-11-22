pipeline {
    agent {
        label 'node1' // Or 'any', 'none', 'docker', etc.
    }
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
                sh "docker build -t demoapp . "
                sh "docker tag demoapp:latest 660656678331.dkr.ecr.us-east-1.amazonaws.com/demo:$env.BUILD_NUMBER"
                }
            }
        stage('Push image to ECR') {
        steps {
                script{
                        docker.withRegistry('https://660656678331.dkr.ecr.us-east-1.amazonaws.com/demo', 'ecr:us-east-1:awscredentials') {
                       sh "docker push 660656678331.dkr.ecr.us-east-1.amazonaws.com/demo:$env.BUILD_NUMBER"
                    }
                }
            }
        }
   }
}
