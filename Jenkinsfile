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
                      sh 'terrafom -v'
                      sh 'which terraform'
                      '''  
                  )
             // }
            }

        }
        stage('apply'){
            steps{
              //sshagent(['git_cred']){
                  sh(
                      '''
                      sh 'inspec -v'
                      sh 'which inspec'
                      '''  
                  )
              //}
            }

        }
    
    }
}