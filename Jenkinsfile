pipeline {
    agent { label 'Jenkins-Agent' }

    environment {
        AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID"
        AWS_DEFAULT_REGION="region" // e.g us-east-1
        IMAGE_REPO_NAME="YOUR_REPO_NAME"
        IMAGE_TAG="YOUR_IMAGE_TAG" // eg. latest, v1
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
                git branch: 'main', credentialsId: 'github', url: 'YOUR_GITHUB_URL'
            }
        }

        stage("Pull Docker Image from Docker Hub"){
            steps {
                script {
                    sh "docker pull vaultwarden/server"
                }
            }
        }

        stage("Tag Docker Image") {
            steps {
                script {
                    sh "docker tag vaultwarden/server ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage("Trivy Scan and Docker Image push") {
            steps {
                script {
                    // Execute trivy scan
                    sh "docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ${REPOSITORY_URI}:${IMAGE_TAG} --no-progress --exit-code 0 --format table"

                    echo "Scan completed. Proceeding with the push to ECR."
                    // Now you can push the image to ECR
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
        }
    }
}


        stage("Trivy Scan and Docker Image push (unused)") {
            when {
                expression { false } // Stage will not be used, just used for example.
            }
            steps {
                script {
                    def scanOutput = sh(script: "docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ${REPOSITORY_URI}:${IMAGE_TAG} --no-progress -scanners vuln --exit-code 0 --severity HIGH,CRITICAL --format table", returnStatus: true)

                    if (scanOutput == 0) {
                        echo "No critical issues found. Proceeding with the push to ECR."
                        sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                    } else {
                        error "Critical security issues were found. We will not proceed with the image push."
                    }
                }
            }
        }
    }
}