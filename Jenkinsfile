pipeline {
    agent any

    parameters {
        choice(name: 'Browsersite', choices: ['Chrome', 'Edge'], description: 'Code to run on browser')
    }

    tools {
        maven "MAVEN_HOME"
        jdk "JAVA_HOME"
       
    }

    stages {
        stage('Build and test') {
            steps {
                script {
                    // Use double quotes for variable interpolation
                    echo "Selected Browser: ${params.Browsersite}"
                    bat "mvn clean test -DBrowser=${Browsersite}"
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Pass Browsersite as an environment variable to Maven
                    withEnv(["BROWSER=${Browsersite}"]) {
                        // Build the package
                        bat "mvn clean package -Dmaven.test.skip=true"
                        bat 'mvn surefire-report:report'  // Corrected this line to use 'surefire-report:report'
                    }
                }
            }
        }
        stage('docker build'){
            steps{
                script{
                    bat "docker build -t admin668/javaproject:Latest ."
                }
            }
        }
        stage('Docker login & publish') {
            steps {
                script {

                    withCredentials([string(credentialsId: 'Docker-hub', variable: 'DockerIntegration-hub')]){
                  //  withDockerRegistry([credentialsId: 'Docker', url: 'https://index.docker.io/v2/']) 
                    bat "docker login -u admin668 -p DockerIntegration-hub"
                    bat "docker push admin668/javaproject:Latest ."
                            
                    }
                    
                }
            }
        }

        stage('Post Build') {
            steps {
                script {
                    junit '**target/surefire-reports/junitreports/TEST-mavenforjenkins.UITest.xml'
                    archiveArtifacts allowEmptyArchive: true, artifacts: 'target/*.jar'
                }
            }
        }
    }
}
