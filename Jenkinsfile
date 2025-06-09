pipeline {
  agent any

  stages {
    // 1) Preguntar si hacemos rollback y capturar el tag a desplegar
    stage('Seleccionar acción') {
      steps {
        script {
          def doRollback = input(
            message: '¿Deseas hacer rollback?',
            parameters: [
              booleanParam(name: 'ROLLBACK', defaultValue: false, description: 'Marca para rollback')
            ]
          )
          if (doRollback) {
            env.TAG_TO_DEPLOY = input(
              message: '¿Qué número de build quieres desplegar?',
              parameters: [
                string(name: 'BUILD_NUMBER', defaultValue: '', description: 'Número de build existente')
              ]
            )
          } else {
            env.TAG_TO_DEPLOY = env.BUILD_NUMBER
          }
        }
      }
    }

    // 2) Sólo construir si es un despliegue nuevo
    stage('Build') {
      when {
        expression { env.TAG_TO_DEPLOY == env.BUILD_NUMBER }
      }
      steps {
        echo "Building image myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
        sh "docker build -t myrepo/nginxapp:${env.TAG_TO_DEPLOY} ."
      }
    }

    // 3) Push SIEMPRE, tanto para rollback como para despliegue normal
    stage('Push') {
      steps {
        echo "Pushing image myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
        //sh "docker push myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
      }
    }

    // 4) Deploy: pull + run con el tag seleccionado
    // stage('Deploy') {
    //   steps {
    //     echo "Desplegando myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //     sh "docker stop nginxapp || true"
    //     sh "docker rm nginxapp   || true"
    //     sh "docker pull myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //     sh "docker run -d --name nginxapp -p 8080:80 myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //   }
    // }
  }
}
