pipeline {
  agent {
    docker {
      image 'khangeshmatte123/jenkins-linux-agent:1.0.0'
      args '-u root' 
    }
  }

  environment {
    CONAN_HOME = "${WORKSPACE}/.conan2"
  }

  stages {
    stage('Checkout') {
      steps {   
        checkout scm
        sh 'ls -la'
      }
    }

    stage('Build') {
      steps {
            dir("${env.WORKSPACE}") {
            sh '''
                conan profile detect --force
                conan install . --build=missing --output-folder=build
                cmake -G "Unix Makefiles" \
                  -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake \
                  -DCMAKE_BUILD_TYPE=Release \
                  -B build -S .

                cmake --build build
            '''
            }
       }
    }

    stage('Archive') {
      steps {
        archiveArtifacts artifacts: 'build/**', allowEmptyArchive: true
      }
    }
  }

  post {
    always {
      echo 'Build pipeline finished.'
    }
    failure {
      echo 'Build failed!'
    }
  }
}
