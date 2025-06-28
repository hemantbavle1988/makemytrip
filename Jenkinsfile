pipeline {
    agent any
    tools {
        maven 'maven-3.9.10'  // same name as configured above
    }
    stages {
        stage('Checkout') {
            steps {
                echo "------Checkout Phase------"

                git 'https://github.com/hemantbavle1988/makemytrip.git'
            }
        }
        stage('Compile') {
            steps {

                echo "------Compile Phase------"
                sh 'mvn clean compile'
            }
        }
        stage('Build') {
            steps {

                echo "------Build Phase------"
                sh 'mvn clean install'
            }
        }

        stage('Post Build') {
                    steps {

                        echo "------Post Build Phase------"
                    }
         }


    }
}
