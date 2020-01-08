pipeline {
    agent { label 'master'}

    parameters{
        string(name: 'KEY', defaultValue: 'here', description: 'key')
        string(name:'TOKEN', defaultValue: 'here', description: 'token')
    }
    stages {
        stage('Plan'){
            steps{
             // sshagent(['git_cred']){
                  sh(
                      '''
                      echo -e "\nplan stage\n"
                      echo "Terraform plan"
                      sh('whoami')
                      sh('pwd')
                      '''  
                  )
             // }
            }

        }
        stage('apply'){
            steps{
              sshagent(['git_cred']){
                  sh(
                      '''
                      echo -e "\nPlanning\n"
                      echo "Terraform plan"
                      sh('ls')
                      sh('pwd')
                      '''  
                  )
              //}
            }

        }
    
    }
}