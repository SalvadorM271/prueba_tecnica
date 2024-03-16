pipeline {
    agent {
        kubernetes {
            yamlFile 'agent.yml'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'echo passed'
                // the repo gets checkout when jenkinsfile is fetched
            }
        }

        stage('Static Code Analysis') {
            steps {
                container('maven') {
                    script {
                        env.SONAR_URL = "https://sonar.mycloudprojects.uk"
                        withCredentials([string(credentialsId: 'sonar', variable: 'SONAR_AUTH_TOKEN')]) {
                        sh "mvn clean install"
                        sh "mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=$SONAR_URL"
                        }
                    }
                }
            }
        }

        stage('Build and push image to ECR') {
            steps {
                container('shell') {
                    script {
                        env.TAG = sh(script: 'echo "$(date +%Y-%m-%d.%H.%M.%S)-${BUILD_ID}"', returnStdout: true).trim()
                        env.APP = "438555236323.dkr.ecr.us-east-1.amazonaws.com/prueba_tecnica"
                        sh "echo building image..."
                        sh "/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination=$APP:$TAG"
                    }
                }
            }
        }
        

     
    }
}