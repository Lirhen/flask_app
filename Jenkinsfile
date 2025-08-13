pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = '992382545251' // Replace with your AWS Account ID
        AWS_REGION = 'us-east-1'         // Replace with your AWS Region (e.g., us-east-1)
        ECR_REPOSITORY_NAME = 'flask_app' // Replace with your ECR repository name
        IMAGE_TAG = "latest"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${ECR_REPOSITORY_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push to AWS ECR') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'aws-credentials-id')]) {
			sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                    	sh "docker tag ${ECR_REPOSITORY_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}"
                    	sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean up workspace after build
        }
    }
}
