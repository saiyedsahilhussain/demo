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
        sh 'sudo yum install npm'
        sh 'npm test'
      }
    }
    stage("build"){
      steps{
        sh 'npm runn build'
      }
    }
  }
}
