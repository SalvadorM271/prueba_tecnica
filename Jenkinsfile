pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: maven
            image: maven:alpine
            command:
            - cat
            tty: true
          - name: docker
            image: crimson2022/custom_agent
            command:
            - cat
            tty: true
            volumeMounts:
             - mountPath: /var/run/docker.sock
               name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock    
        '''
    }
  }
  stages {

    stage('Build-Docker-Image') {
      steps {
        container('docker') {
            script {
                env.TAG = sh(script: 'echo "$(date +%Y-%m-%d.%H.%M.%S)-${BUILD_ID}"', returnStdout: true).trim()
                env.APP = "438555236323.dkr.ecr.us-east-1.amazonaws.com/prueba_tecnica"
                docker build --tag $APP:$TAG .
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