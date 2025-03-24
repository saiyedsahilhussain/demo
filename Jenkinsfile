pipeline {
    agent any
    environment {
        scannerHome = tool 'sonarqube-scanner' 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube-server') {  // Use your SonarQube server name here
                    sh  '${scannerHome}/bin/sonar-scanner'
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}
