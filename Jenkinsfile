pipeline {
  agent {
    docker {
      image 'khangeshmatte123/conan-cmake-sonar:1.0.2'
      args '-u root' 
    }
  }

  environment {
    CONAN_HOME = "${WORKSPACE}/.conan2"
    SONARQUBE_ENV = 'sonarqube-server' // match the name you gave in Jenkins config
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
            rm -rf build
            conan profile detect --force
            conan install . --build=missing --output-folder=build/Release
            cmake -G "Unix Makefiles" \
              -DCMAKE_TOOLCHAIN_FILE=build/Release/generators/conan_toolchain.cmake \
              -DCMAKE_BUILD_TYPE=Release \
              -B build/Release -S .
            cmake --build build/Release
          '''
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv("${SONARQUBE_ENV}") {
          sh '''
            sonar-scanner \
              -Dsonar.projectKey=my-project-key \
              -Dsonar.sources=. \
              -Dsonar.host.url=http://192.168.242.163:9000
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
