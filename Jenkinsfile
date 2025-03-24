pipeline {
    agent any
    environment {
        scannerHome = tool 'sonarqube-scanner'  // Assumes 'sonarqube-scanner' is defined as a global tool in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarQube-server') {  // Use your SonarQube server name here
                    sh  "${scannerHome}/bin/sonar-scanner"  // Double quotes for variable interpolation
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
