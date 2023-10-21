pipeline {
    agent { label 'Jenkins-Agent' }

    environment {
        AWS_ACCOUNT_ID="878893543361"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="mvarela-io/vaultwarden"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }
        }

        stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/mateus-varela/vaultwarden'
            }
        }

        stage("Pull Docker Image from Docker Hub"){
            steps {
                script {
                    sh "docker pull vaultwarden/server"
                }
            }
        }

        stage("Tag Docker Image"){
            steps {
                script {
                    sh "docker tag vaultwarden/server ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage("Push Docker Image to ECR"){
            steps {
                script {
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }
        stage("Trivy Scan"){
            steps {
                script {
                    sh "docker run -v /var/run/docker.sock:var/run/docker.sock aquasec/trivy image ${REPOSITORY_URI}:${IMAGE_TAG} --no-progress -scanners vuln --exit-code 0 --severity HIGH,CRITICAL --format table"
                }
            }
        }
    }
}
