pipeline {
  agent any
  stages {
    stage ("checkout"){
      steps{
        checkout scm
      }
    }
    stage("test"){
      steps{
      
        sh 'npm test'
      }
    }
    stage("build"){
      steps{
        sh 'npm run build'
      }
    }
    stage("build image"){
      steps{
        sh 'docker build  -t demoimage1.0 .'
      }
    }
    stage("Push image"){
      steps{
        withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]){
          sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
          sh 'docker tag demoimage1.0 sahilhussain12/demoimage1.0'
          sh 'docker push sahilhussain12/demoimage1.0'
          sh 'docker logout' 
        }
      }
    }
  }
}
