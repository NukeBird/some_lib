pipeline { 
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
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
                zip zipFile: 'some_lib.zip', archive: false, dir: 'install'
                archiveArtifacts artifacts: 'some_lib.zip', fingerprint: true
                sh '''rm -rf some_lib.zip'''
                
                withCredentials([usernamePassword(credentialsId: '3efc50db-d9ca-431b-9d2a-91f3523c33cd', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {

                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/NukeBird/some_lib')
                }
            }
        }
    }
}
