pipeline {
  agent any

  stages {
    stage('Seleccionar Tag a Desplegar') {
      steps {
        script {
          env.ROLLBACK_TAG = input(
            message: '¿Qué número de build quieres desplegar?',
            parameters: [string(name: 'BUILD_NUMBER', defaultValue: '1', description: 'Build number')]
          )
        }
      }
    }

    stage('Deploy Rollback') {
      steps {
        script {
          echo "Haciendo rollback al build ${env.ROLLBACK_TAG}"
          sh "docker stop nginxapp || true"
          sh "docker rm  nginxapp || true"
          sh "docker pull myrepo/nginxapp:${env.ROLLBACK_TAG}"
          sh "docker run -d --name nginxapp -p 8080:80 myrepo/nginxapp:${env.ROLLBACK_TAG}"
        }
      }
    }
  }
}
