pipeline {
  agent any

  stages {
    stage('Checkout & Build Docker Image') {
      steps {
        // Construye la imagen y la etiqueta con el número de build
        sh 'docker build -t nginxapp:${BUILD_NUMBER} .'
      }
    }

    stage('Run Container') {
      steps {
        // Arranca el contenedor con nombre para poder hacer exec después
        sh """
          docker run \
            --name nginxapp-${BUILD_NUMBER} \
            -d -p 8080:80 \
            nginxapp:${BUILD_NUMBER}
        """
      }
    }

    stage('List Containers') {
      steps {
        // Muestra contenedores activos
        sh 'docker ps'
      }
    }

    stage('Inspect HTML Files') {
      steps {
        // Lista el contenido de la carpeta de nginx dentro del container
        sh "docker exec nginxapp-${BUILD_NUMBER} ls -la /usr/share/nginx/html/"
      }
    }
  }

  post {
    always {
      // Opcional: elimina el contenedor y la imagen (o limpia workspace)
      sh """
        docker rm -f nginxapp-${BUILD_NUMBER} || true
        docker rmi nginxapp:${BUILD_NUMBER} || true
      """
    }
  }
}
