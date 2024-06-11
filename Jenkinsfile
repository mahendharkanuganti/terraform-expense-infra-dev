pipeline {
    agent {
        label "AGENT-1"
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
   
    stages {
        stage('Init') {
            steps {
                sh """
                    cd  01-vpc
                    terraform init -reconfigure
                """
            }
        }
        stage('Plan') {
            steps {
                echo "this is pipeline stage 2"
            }
        }
        stage('Deploy') {
            steps {
                echo "this is pipeline stage 3"
            }
        }
    
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
        success { 
            echo 'I will run when pipeline is success'
        }
        failure { 
            echo 'I will run when pipeline is failed'
        }
    }
}