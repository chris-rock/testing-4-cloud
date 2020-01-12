pipeline {
    agent { label 'master'}

    parameters{
        string(name: 'KEY', defaultValue: 'here', description: 'key')
        string(name:'TOKEN', defaultValue: 'here', description: 'token')
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
    
    }
}