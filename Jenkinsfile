pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "alialhoumsi"
        IMAGE_TAG = "1.0.0"  // يمكنك تغييره حسب نسختك
        EMAIL_RECIPIENTS = "ali.houmsi1234@gmail.com" // ضع ايميلك هنا
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ali-AlHoumsi/docker-jenkins-pro-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t jenkins-pro-api:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh "docker run --rm jenkins-pro-api:${IMAGE_TAG} npm test"
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo "$PASS" | docker login -u "$USER" --password-stdin'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker tag jenkins-pro-api:${IMAGE_TAG} $DOCKERHUB_USER/jenkins-pro-api:${IMAGE_TAG}"
                    sh "docker push $DOCKERHUB_USER/jenkins-pro-api:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker rm -f jenkins-pro-app || true"
                    sh "docker run -d -p 3000:3000 --name jenkins-pro-app $DOCKERHUB_USER/jenkins-pro-api:${IMAGE_TAG}"
                }
            }
        }
    }
}
