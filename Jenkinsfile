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
            environment {
                BROWSER = "'${params.Browsersite}'"
            }
            steps {
                script {
                    echo "Selected Browser: ${BROWSER}"
                    // Pass BROWSER as an environment variable to Maven
                    bat "mvn clean test -DBrowser=${BROWSER}"
                }
            }
        }

        stage('Results') {
            environment {
                BROWSER = "'${params.Browsersite}'"
            }
            steps {
                script {
                    // Build the package
                    bat "mvn clean package -Dmaven.test.skip=true"
                    
                    // Run Surefire report generation
                    bat "mvn surefire-report:report"
                }
            }
        }
    }

    post {
        success {
            archiveArtifacts allowEmptyArchive: true, artifacts: 'target/*.jar'
        }
    }
}
