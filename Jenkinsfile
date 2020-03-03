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
                sshagent (credentials: ['8875e994-f71a-4ec8-9d4e-387f591b254c']) {
                    sh("git tag -a some_tag -m 'Jenkins'")
                    sh('git push --tags')
                }
            }
        }
    }
}
