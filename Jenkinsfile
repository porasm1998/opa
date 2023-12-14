pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Replace with your VCS repository details
                git(url: 'https://github.com/porasm1998/opa.git', branch: 'main')
            }
        }

         stage('Check OPA Installation') {
            steps {
                bat 'opa version'
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out plan.out'
                bat 'terraform show -json plan.out > plan.json'
            }
        }

        stage('OPA Policy Check') {
            steps {
                // Assuming OPA is installed and accessible from command line on Windows
                bat 'opa eval --format pretty --data instance_policy.rego --input plan.json "data.terraform.deny"'
            }
        }

        stage('Handle OPA Results') {
            steps {
                script {
                    def opaOutput = bat(script: 'opa eval --format raw --data instance_policy.rego --input plan.json "data.terraform.deny"', returnStdout: true).trim()
                    if (opaOutput != "[]") {
                        error("Policy violation: ${opaOutput}")
                    }
                }
            }
        }
    }
}
