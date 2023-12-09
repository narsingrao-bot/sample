pipeline {
    agent any

    parameters {
     choice(name: 'Browsersite', defaultValue: ['Chrome', 'Edge'], description: 'Code to run on browser')
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
                // install the package
                     bat  "mvn clean package -Dmaven.install.directory=target"
                   
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
