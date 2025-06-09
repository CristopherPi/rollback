pipeline {
    agent any 

    stages{
        stage{
            step{
                sh 'docker build -t nginxapp:${BUILD_NUMBER} .'
            }
        

            step{
                sh 'docker run -d -p 8080:80 nginxapp:${BUILD_NUMBER}'
            }

            step{
                sh 'docker ps'
            }

            step{
                sh 'docker exec -it nginxapp:${BUILD_NUMBER} /bin/bash'
            }

            step{
                sh 'cat /usr/share/nginx/html/'
            }
        }

    }
}