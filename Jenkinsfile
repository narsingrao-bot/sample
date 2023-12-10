pipeline {
    agent any

    parameters {
        choice(name: 'Browsersite', choices: ['Chrome', 'Edge'], description: 'Code to run on browser')
    }

    tools {
        maven "MAVEN_HOME"
    }
    
    stages {
        stage('Build and test') {
            steps {
                script {
                    // Use double quotes for variable interpolation
                    bat "mvn clean test -DBrowser=${Browsersite}"
                }
            }
        }

        stage('Results') {
            steps {
                script {
                    // Pass Browsersite as an environment variable to Maven
                    withEnv(["BROWSER=${Browsersite}"]) {
                        // Build the package
                        bat "mvn clean package -Dmaven.test.skip=true"

                        // Move the JAR file to the target folder
                       // bat 'move target\\*.jar .\\target\\C:\\Users\\Narsing\\.jenkins\\workspace\\new_instance\\'
                    }
                }
            }
        }
    }

    post {
        success {
             
            archiveArtifacts allowEmptyArchive: true, artifacts: 'C:\\Users\\Narsing\\Desktop\\sample\\target\\*.jar'
        }
    }
}
