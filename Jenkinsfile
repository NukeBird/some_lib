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
                sh('''
                    git config --local credential.helper "!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f"
                    git push --tag
                ''')
            }
        }
    }
}
