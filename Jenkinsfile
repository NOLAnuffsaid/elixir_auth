pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile.test'
      args '--name docker-update_$(date "+%j_%H.%M.%S")'
    }
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
