pipeline {

    agent any

    parameters {

        choice(
            name: 'ACTION',
            choices: ['START', 'STOP'],
            description: 'Select ECS operation'
        )

        choice(
            name: 'ENVIRONMENT',
            choices: ['beta'],
            description: 'Environment'
        )
    }

    stages {

        stage('Cleaning the Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Setting Build Info') {
            steps {
                echo "================================"
                echo "Environment : ${params.ENVIRONMENT}"
                echo "Action      : ${params.ACTION}"
                echo "Build       : ${env.BUILD_NUMBER}"
                echo "================================"
            }
        }

        stage('AWS Connection Test') {
            steps {
                sh '''
                    aws sts get-caller-identity
                '''
            }
        }

        stage('ECS Update') {
            steps {
                sh """
                    ./scripts/ecs.sh ${params.ACTION}
                """
            }
        }
    }

    post {

        success {
            echo "ECS operation completed successfully."
        }

        failure {
            echo "ECS operation failed."
        }
    }
}
