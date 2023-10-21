pipeline {
    agent { label 'Jenkins-Agent' }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        AWS_ACCOUNT_ID="YOUR_ACCOUND_ID"
        AWS_DEFAULT_REGION="CREATED_AWS_ECR_REPO" #e.g. us-east-1
        IMAGE_REPO_NAME="ECR_REPO_NAME"
        IMAGE_TAG="IMAGE_TAG" #eg. v1, latest
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/mateus-varela/vaultwarden'
            }
        }

        stage("Build Docker Image"){
            steps {
                script {
                    docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .
                }
            }
        }

        stage("Push Docker Image to ECR"){
            steps {
                script {
                    docker login -u AWS -p $(aws ecr get-login-password --region $AWS_DEFAULT_REGION) $REPOSITORY_URI
                    docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
                    docker push $REPOSITORY_URI:$IMAGE_TAG
                }
            }
        }

        stage("Trivy Scan"){
            steps {
                script {
                    docker run -v /var/run/docker.sock:var/run/docker.sock aquasec/trivy image $REPOSITORY_URI:$IMAGE_TAG --no-progress -scanners vuln --exit-code 0 --severity HIGH,CRITICAL --format table
                }
            }
        }
    }
}