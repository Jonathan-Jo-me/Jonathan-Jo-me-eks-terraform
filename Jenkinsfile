pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1' // The AWS region for deployment
        TF_VAR_region = "${AWS_REGION}" // Terraform variable for region
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out the terraform code"
                checkout scm  // Checks out the code from the configured repository in Jenkins
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', region: AWS_REGION)]) {
                    // Initialize Terraform with the AWS credentials
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', region: AWS_REGION)]) {
                    // Run Terraform plan
                    sh 'terraform plan '
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', region: AWS_REGION)]) {
                    // Apply the Terraform plan
                    sh 'terraform apply -auto-approve '
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', region: AWS_REGION)]) {
                    // Destroy the Terraform-managed infrastructure
                    input message: 'Finished using the EKS cluster? (Click "Proceed" to continue)'
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
