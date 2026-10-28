
pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    parameters {
        string(
            name: 'SSH_ALLOWED_CIDR',
            defaultValue: '203.0.113.10/32',
            description: 'Replace with your public IPv4 address followed by /32'
        )
    }

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Tools and AWS Identity') {
            steps {
                sh '''
                    set -eu
                    git --version
                    terraform version
                    aws sts get-caller-identity
                '''
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withEnv(["TF_VAR_ssh_allowed_cidr=${params.SSH_ALLOWED_CIDR}"]) {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Approve Infrastructure') {
            steps {
                input(
                    message: 'Review the plan. Create the AWS infrastructure?',
                    ok: 'Approve deployment'
                )
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false -auto-approve tfplan'
            }
        }

        stage('Show Outputs') {
            steps {
                sh 'terraform output'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }

        success {
            echo 'Terraform deployment completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Review Console Output before retrying.'
        }
    }
}
