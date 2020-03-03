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
    }
    post { 
        success {
            zip zipFile: 'some_lib.zip', archive: false, dir: 'install'
            archiveArtifacts artifacts: 'some_lib.zip', fingerprint: true
            sh '''rm -rf some_lib.zip'''
            sh '''git config --local credential.helper "!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f"'''
            sh '''git push origin HEAD:$TARGET_BRANCH'''
            sh '''git push --tag'''
        }
    }
}
