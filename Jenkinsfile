pipeline {
    agent {
         kubernetes {
            defaultContainer 'jnlp'
         }
    }
    stages {
        stage('Checkout') {
        steps {
            // since i have configure branch discovery this is not needed
            sh 'echo passed'
        }
        }
        stage('Install dependencies') {
        steps {
            sh 'apt-get update'
            sh 'apt-get install -y aws-cli'
            sh 'aws --version'
        }
        }
        stage('pre-run set up') {
        environment {
                AWS_REGION = "us-east-1"
                ECR_REGISTRY_ID = "438555236323"
        }
        steps {
            script {
                env.TAG = sh(script: 'echo "$(date +%Y-%m-%d.%H.%M.%S)-${BUILD_ID}"', returnStdout: true).trim()
                // Log in to ECR and authenticate Docker client
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                def ecrLogin = sh(script: "aws ecr get-login --no-include-email --region ${AWS_REGION} --registry-ids ${ECR_REGISTRY_ID}", returnStdout: true).trim()
                //  prevent the Docker login command and authentication token from being displayed in the Jenkins log output
                sh "${ecrLogin} > /dev/null"
                }
            }
        }
        }
        stage('Build and push') {
            environment {
                APP = "438555236323.dkr.ecr.us-east-1.amazonaws.com/prueba_tecnica"
            }
            steps {
                
                script {
                    sh """
                    echo \"Build started on `date`\"
                    echo Building the Docker image...
                    docker build --tag $APP:$TAG .
                    echo \"Build completed on `date`\"
                    echo Pushing the Docker image to ECR Repository
                    docker push $APP:$TAG
                    echo \"Docker Image Push to ECR Completed -  $APP:$TAG\"
                    """
                }
                
            }
        }
        
    }
}   