pipeline {
    agent any

    parameters {
        string(name: 'Browsersite', defaultValue: 'Chrome', description: 'Code to run on browser')
    }

    tools {
        maven "MAVEN_HOME"
    }
    
    stages {
        stage('Build and test') {
            steps {
                script{
             bat "mvn clean test -DBrowser=${Browsersite}"                
            }
        }

        }     
        stage('Results') {
            steps {
                script {
                    // Pass Browsersite as an environment variable to Maven
                    withEnv(["BROWSER=${Browsersite}"]) {
                        bat "mvn clean package"
                    }
                }
            }
        }
    }

    post {
        success {
            junit '**/target/surefire-reports/TEST-*.xml'
            archiveArtifacts 'target/*.jar'
        }
    }
}
