pipeline {
  agent any

  stages {
    stage('Seleccionar acción') {
      steps {
        script {
          // 1) Preguntamos si queremos rollback
          def doRollback = input(
            message: '¿Deseas hacer rollback?',
            parameters: [
              booleanParam(
                name: 'ROLLBACK',
                defaultValue: false,
                description: 'Marca para volver a un build anterior'
              )
            ]
          )

          // 2) Si es rollback, pedimos el número de build; si no, usamos el BUILD_NUMBER actual
          if (doRollback) {
            env.TAG_TO_DEPLOY = input(
              message: '¿Qué número de build quieres desplegar?',
              parameters: [
                string(
                  name: 'BUILD_NUMBER',
                  defaultValue: '',
                  description: 'Número de build a desplegar'
                )
              ]
            )
          } else {
            env.TAG_TO_DEPLOY = env.BUILD_NUMBER
          }
        }
      }
    }

    stage('Build & Push') {
      // Sólo cuando no hay rollback
      when {
        expression { env.TAG_TO_DEPLOY == env.BUILD_NUMBER }
      }
      steps {
        echo "Construyendo y empujando imagen con tag ${env.TAG_TO_DEPLOY}"
        sh "docker build -t myrepo/nginxapp:${env.TAG_TO_DEPLOY} ."
        // sh "docker push myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
      }
    }

    // stage('Deploy') {
    //   steps {
    //     echo "Desplegando la imagen myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //     // Para simplificar, siempre hacemos pull+run, tanto en deploy nuevo como en rollback
    //     sh "docker stop nginxapp || true"
    //     sh "docker rm  nginxapp || true"
    //     sh "docker pull myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //     sh "docker run -d --name nginxapp -p 8080:80 myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
    //   }
    // }
  }
}

