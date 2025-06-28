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
        stage ('Docker ')

    }
}
