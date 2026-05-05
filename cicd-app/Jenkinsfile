pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        BACKEND_IMAGE = "Rajesh1187/cicd-backend:${IMAGE_TAG}"
        FRONTEND_IMAGE = "Rajesh1187/cicd-frontend:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'github-ssh',
                url: 'git@github.com:Rajesh1187/cicd-app.git'
            }
        }

        stage('Test Backend') {
            steps {
                sh """
                cd backend
                pip install -r requirements.txt
                pytest
                """
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
