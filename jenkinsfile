pipeline {
    agent any
    tools {
        maven 'maven3'  // same name as configured above
    }
    stages {
        stage('Checkout') {
            steps {
                git pull 'https://github.com/hemantbavle1988/makemytrip.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
    }
}
