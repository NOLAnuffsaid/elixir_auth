pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('Tests') {
      steps {
        step {
          echo "Successful build!"
        }
      }
    }
  }
  post {
    always {
      junit '/tmp/*.xml'
    }
  }
}
