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
        sh 'docker build  -t demoimage:demoimage1.0 .'
      }
    }
  }
}
