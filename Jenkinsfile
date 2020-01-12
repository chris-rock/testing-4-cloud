pipeline {
    agent { label 'master'}

    parameters{
        string(name:'AWS_ACCESS_KEY', defaultValue: '', description: 'AWS_ACCESS_KEY')
        string(name:'AWS_SECRET_ACCESS_KEY', defaultValue: '', description: 'AWS_SECRET_ACCESS_KEY')
    }
    stages {
        stage('Terraform Install'){
            steps{
                  sh(
                      '''
                      sh 'scripts/terraform-install.sh'
        
                      '''  
                  )
            }

        }
        stage('Terraform init'){
            steps{
                  sh(
                      '''
                      sh 'scripts/terraform-init.sh'
                      '''  
                  )
            }

        }
        stage('Terraform Plan'){
            steps{
                  sh(
                      '''
                      sh 'scripts/terraform-plan.sh'
                      '''  
                  )
            }
        }
        stage('Terraform apply'){
            steps{
                  sh(
                      '''
                      echo 'Terraform apply here'
                      '''  
                  )
            }
        }
        stage('Terraform out'){
            steps{
                  sh(
                      '''
                      echo 'Terraform out here'
                      '''  
                  )
            }
        }
        stage('Inspec binary install'){
            steps{
                  sh(
                      '''
                      echo 'Inspec binary install'
                      '''  
                  )
            }
        }
        stage('Inspec test execution'){
            steps{
                  sh(
                      '''
                      echo 'Inspec test execution'
                      '''  
                  )
            }
        }
    }
}