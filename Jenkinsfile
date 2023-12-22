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
                    bat 'docker build -t admin668/javatech .'
                }
            }
        }
        stage('Docker build & publish') {
            steps {
                script {
                   // withDockerRegistry([credentialsId: 'Docker', url: 'https://index.docker.io/v2/']) 
                      withCredentials([string(credentialsId: 'Dockerint-hub', variable: 'Dockerhub')]) {
                        bat "docker login -u admin668 -p ${Dockerhub}"
    
                    }
                       // bat "docker build -t admin668/jenkins-doc:Latest -f Dockerfile ."
                        bat "docker push admin668/javatech"
                    }
                }
            }
        

        stage ('post build'){
            steps {
                script {
                    junit '**target/surefire-reports/junitreports/TEST-mavenforjenkins.UITest.xml'
                    archiveArtifacts allowEmptyArchive: true, artifacts: 'target/*.jar'
                }
            }
        } 
    }
}

