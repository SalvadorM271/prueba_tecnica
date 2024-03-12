pipeline {
    agent {
        kubernetes {
            yamlFile 'agent.yml'
        }
    }
    stages {

        stage('Log_in_to_ecr') {
            steps {
                container('docker') {
                    script {
                        env.TAG = sh(script: 'echo "$(date +%Y-%m-%d.%H.%M.%S)-${BUILD_ID}"', returnStdout: true).trim()
                        env.APP = "438555236323.dkr.ecr.us-east-1.amazonaws.com/prueba_tecnica"
                        env.ACC = "438555236323"
                        env.REGION = "us-east-1"
                        sh "aws ecr get-login-password --region \${REGION} | docker login --username AWS --password-stdin \${ACC}.dkr.ecr.us-east-1.amazonaws.com > /dev/null"
                        
                    }
                }
            }
        }
        stage('Build-Docker-Image') {
            steps {
                container('docker') {
                    script {
                        sh "echo building image..."
                        sh "docker build --tag \${APP}:\${TAG} ."
                    }
                }
            }
        }
        stage('test-scope') {
            steps {
                container('docker') {
                sh 'echo $TAG'
                }
            }
        }
     
    }
}