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
        sh "docker build -t myapp/nginxapp:${env.TAG_TO_DEPLOY} ."
        // sh "docker push myrepo/nginxapp:${env.TAG_TO_DEPLOY}"
      }
    }




    stage('Check image tag') {
        steps {
          script {
        echo "Verificando que la imagen con tag ${env.TAG_TO_DEPLOY} existe"
            def imageExists = sh(script: "docker images -q myapp/nginxapp:${env.TAG_TO_DEPLOY}", returnStatus: true) == 0
            if (!imageExists) {
              error "La imagen con tag ${env.TAG_TO_DEPLOY} no existe. Abortando."
            } else {
              echo "La imagen con tag ${env.TAG_TO_DEPLOY} existe."
            }
          }
        }
    }
  }
}

