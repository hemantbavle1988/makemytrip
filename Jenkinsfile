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
        // stage('Building & Tag Docker Image') {
        //     steps {
        //         echo "Starting Building Docker Image"
        //         sh "docker build -t hemantbavle1988/mmt-repo ."
        //         sh "docker build -t mmt-repo ."
        //         echo 'Docker Image Build Completed'
        //     }
        // }
        // stage('Docker Image Scanning') {
        //     steps {
        //         echo 'Docker Image Scanning Started'
        //         sh 'docker --version'
        //         echo 'Docker Image Scanning Started'
        //     }
        // }
        // stage('Docker push to Docker Hub') {
        //    steps {
        //     script{
        //             echo "Attempting to Login with Docker credentials.."
        //             withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
        //                 echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        //                 echo "Push Docker Image to DockerHub : In Progress"
        //                 sh 'docker push hemantbavle1988/mmt-repo:latest'
        //                 echo "Push Docker Image to DockerHub : In Progress"
        //             }
        //         }
        //     }   
        // }

        stage('Building & Tag Docker Image') {
            steps {
                echo "Starting Building Docker Image"
                sh "docker build -t mmt-repo ."
                sh "docker tag mmt-repo hemantbavle/mmt-repo:latest"
                echo 'Docker Image Build Completed'
            }
        }

        stage('Docker Image Scanning') {
            steps {
                echo 'Docker Image Scanning Started'
                sh 'docker --version'
                echo 'Docker Image Scanning Completed'
            }
        }

        stage('Docker push to Docker Hub') {
            steps {
                script {
                    echo "Attempting to Login with Docker credentials.."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            echo "Push Docker Image to DockerHub : In Progress"
                            docker push hemantbavle/mmt-repo:latest
                            echo "Push Docker Image to DockerHub : Completed"
                        '''
                    }
                    echo "Attempt completed.."
                }
            }
        }

        // stage('Push Docker Image to AWS ECR') {
        //    steps {
        //       script {
        //          withDockerRegistry([credentialsId:'aws-dev-ops-admin', url:"https://999331376056.dkr.ecr.ap-south-1.amazonaws.com"]){
        //          sh """
        //          echo "List the docker images present in local"
        //          docker images
        //          echo "Tagging the Docker Image: In Progress"
        //          docker tag mmt-repo:latest 999331376056.dkr.ecr.ap-south-1.amazonaws.com/hemantbavle1988/mmt-repo:latest
        //          echo "Tagging the Docker Image: Completed"
        //          echo "Push Docker Image to ECR : In Progress"
        //          docker push 999331376056.dkr.ecr.ap-south-1.amazonaws.com/hemantbavle1988/mmt-repo:latest
        //          echo "Push Docker Image to ECR : Completed"
        //          """
        //          }
        //       }
        //    }
        // }

        stage('Push Docker Image to AWS ECR') {
           steps {
              script {
                 withCredentials([usernamePassword(credentialsId: 'aws-dev-ops-admin', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                     sh '''
                        echo "Configuring AWS CLI"
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set default.region ap-south-1

                        echo "Logging in to AWS ECR"
                        aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 999331376056.dkr.ecr.ap-south-1.amazonaws.com

                        echo "Tagging Docker Image"
                        docker tag mmt-repo:latest 999331376056.dkr.ecr.ap-south-1.amazonaws.com/hemantbavle1988/mmt-repo:latest

                        echo "Pushing Docker Image to ECR"
                        docker push 999331376056.dkr.ecr.ap-south-1.amazonaws.com/hemantbavle1988/mmt-repo:latest
                     '''
                 }
              }
           }
        }


    }
}
