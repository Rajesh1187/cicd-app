pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        BACKEND_IMAGE = "rajesh1187/cicd-backend:${BUILD_NUMBER}"
        FRONTEND_IMAGE = "rajesh1187/cicd-frontend:${BUILD_NUMBER}"
        K8S_REPO = "git@github.com:Rajesh1187/cicd-k8s-manifests.git"
    }

    stages {

        stage('Test') {
            steps {
                sh '''
                pip install -r backend/requirements.txt
                python3 -m pytest backend/tests
                '''
            }
        }

        stage('Build & Push Docker') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin

                    docker build -t $BACKEND_IMAGE ./backend
                    docker push $BACKEND_IMAGE

                    docker build -t $FRONTEND_IMAGE ./frontend
                    docker push $FRONTEND_IMAGE
                    '''
                }
            }
        }

        stage('Update GitOps Repo (AUTO DEPLOY TRIGGER)') {
            steps {
                sshagent(['github-ssh-key']) {
                    sh '''
                    git clone $K8S_REPO repo
                    cd repo

                    sed -i "s|rajesh1187/cicd-backend:.*|$BACKEND_IMAGE|g" k8s/backend-deployment.yaml
                    sed -i "s|rajesh1187/cicd-frontend:.*|$FRONTEND_IMAGE|g" k8s/frontend-deployment.yaml

                    git config user.email "jenkins@ci.com"
                    git config user.name "jenkins"

                    git add .
                    git commit -m "Auto deploy build $BUILD_NUMBER"
                    git push origin main
                    '''
                }
            }
        }
    }
}
