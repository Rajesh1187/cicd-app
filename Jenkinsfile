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
                cd cicd-app/backend
                pip install -r requirements.txt
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
                docker build -t $BACKEND_IMAGE ./cicd-app/backend
                docker push $BACKEND_IMAGE

                docker build -t $FRONTEND_IMAGE ./cicd-app/frontend
                docker push $FRONTEND_IMAGE
                """
            }
        }
    }
}
