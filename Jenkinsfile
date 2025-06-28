pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: ''))
    }

    tools {
        maven 'maven-3.9.10'  // same name as configured above
    }
    stages {
        stage('Checkout') {
            steps {
                echo "------Checkout Phase Begins------"
                git branch: 'main', url: 'https://github.com/hemantbavle1988/makemytrip.git'
                echo "------Checkout Phase Ends------"

            }
        }
        stage('Compile') {
            steps {

                echo "------Compile Phase Begins------"
                sh 'mvn clean compile'
                echo "------Compile Phase Ends------"
                
            }
        }
        stage('QA Test') {
            steps {

                echo "------ QA Test Begins ------"
                sh 'mvn clean test'
                echo "------ QA Test Ends ------"
            }
        }
        stage('Package') {
            steps {
                echo "------ Code Artifact Creation Begins ------"
                sh 'mvn clean package'
                echo "------ Code Artifact Creation Ends ------"
            }
        }
         stage('Building & Tag Docker Image') {
            steps {
                echo "Starting Building Docker Image"
                sh "docker build -t hemantbavle1988/mmt-repo ."
                sh "docker build -t mmt-repo ."
                echo 'Docker Image Build Completed'
            }
        }
        stage('Docker Image Scanning') {
            steps {
                echo 'Docker Image Scanning Started'
                sh 'docker --version'
                echo 'Docker Image Scanning Started'
            }
        }
        stage('Docker push to Docker Hub') {
           steps {
            script{
                    echo "Attempting to Login with Docker credentials.."
                    withCredentials([string(credentialsId: 'docker-hub-creds', variable: 'dockerhubCred')]){
                        sh 'docker login docker.io -u hemantbavle@gmail.com -p ${dockerhubCred}'
                        echo "Push Docker Image to DockerHub : In Progress"
                        sh 'docker push hemantbavle1988/mmt-repo:latest'
                        echo "Push Docker Image to DockerHub : In Progress"
                    }
                }
            }   
        }

    }
}
