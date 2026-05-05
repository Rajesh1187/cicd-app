pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        BACKEND_IMAGE = "Rajesh1187/cicd-backend:${IMAGE_TAG}"
        FRONTEND_IMAGE = "Rajesh1187/cicd-frontend:${IMAGE_TAG}"
    }

    stages {

        stage('Test Backend') {
            steps {
                sh """
              
                pip install -r backend/requirements.txt
                pytest
                """
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Build & Push') {
            steps {
                sh """
                docker build -t $BACKEND_IMAGE ./backend
                docker push $BACKEND_IMAGE

                docker build -t $FRONTEND_IMAGE ./frontend
                docker push $FRONTEND_IMAGE
                """
            }
        }
    }
}
