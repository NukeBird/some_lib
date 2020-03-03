pipeline { 
    agent any
    stages {
        stage('Generate') { 
            steps { 
                sh '''
                    mkdir -p build local &&
                    cd build &&
                    cmake .. -DCMAKE_INSTALL_PREFIX=../install
                '''
            }
        }
        stage('Compile') { 
            steps { 
                sh '''
                    cd build &&
                    cmake --build . --target install --config Release
                '''
            }
        }
        stage("Push") {
            steps {
                withCredentials([usernamePassword(credentialsId: '3efc50db-d9ca-431b-9d2a-91f3523c33cd', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {

                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@some_lib.git --tags')
                }
            }
        }
    }
}
