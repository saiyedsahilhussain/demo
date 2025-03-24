pipeline {
  agent any

  environment {
         credentialsId : 'sonar-cred'  // Ensure this is your SonarQube token ID in Jenkins credentials
        scannerHome = tool 'sonarQube-scanner'  // SonarQube Scanner tool name as per your Jenkins setup
    }
  stages {
    stage("checkout") {
      steps {
        checkout scm
      }
    }
    stage("test") {
      steps {
        sh 'npm test'
      }
    }
    stage("build") {
      steps {
        sh 'npm run build'
      }
    }
    stage("SonarQube analysis") {
      steps {
        withSonarQubeEnv('sonarQube-server') {  // Use your SonarQube server name here
          sh '${scannerHome}/bin/sonar-scanner'
        }
      }
    }
    stage("Quality Gate") {
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
    
    stage("build image") {
      steps {  
        withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
          sh "echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin"
          sh 'docker build -t demoimage1.0 .'
        }
      }
    }
    stage("Push image") {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
          sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
          sh 'docker tag demoimage1.0 sahilhussain12/demoimage1.0'
          sh 'docker push sahilhussain12/demoimage1.0'
          sh 'docker logout'
        }
      }
    }
  }
}
