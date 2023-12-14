pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Replace with your VCS repository details
                git(url: 'https://github.com/porasm1998/opa.git', branch: 'main')
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out plan.out'
                sh 'terraform show -json plan.out > plan.json'
            }
        }

        stage('OPA Policy Check') {
            steps {
                sh 'opa eval --format pretty --data instance_policy.rego --input plan.json "data.terraform.deny"'
            }
        }

        stage('Handle OPA Results') {
            steps {
                script {
                    def opaOutput = sh(script: 'opa eval --format raw --data instance_policy.rego --input plan.json "data.terraform.deny"', returnStdout: true).trim()
                    if (opaOutput != "[]") {
                        error("Policy violation: ${opaOutput}")
                    }
                }
            }
        }

        
    }

    
}
