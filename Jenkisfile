pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Choose Terraform action'
        )
    }

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Bishal-hub/jenkins-cicd-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Format Check') {
            steps {
                bat 'terraform fmt'
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    script {
                        if (params.ACTION == 'apply') {
                            bat 'terraform apply -auto-approve tfplan'
                        } else {
                            bat 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
        always {
        echo "🧹 Cleaning up workspace..."
            cleanWs()
        }
    }
}