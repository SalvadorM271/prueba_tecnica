pipeline {
    agent {
        kubernetes {
            yamlFile 'agent.yml'
        }
    }
    stages {

        stage('Build-Docker-Image') {
            steps {
                container('docker') {
                    sh """
                        env.TAG = sh(script: 'echo "$(date +%Y-%m-%d.%H.%M.%S)-${BUILD_ID}"', returnStdout: true).trim()
                        env.APP = "438555236323.dkr.ecr.us-east-1.amazonaws.com/prueba_tecnica"
                        sh 'docker build --tag ${APP}:${TAG} .
                    """
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