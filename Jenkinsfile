pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('Tests') {
      steps {
        echo "Successful build!"
      }
    }
  }
  post {
    always {
      junit '/tmp/*.xml'
    }
  }
}
