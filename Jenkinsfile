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
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id']
                ]) {
                    sh '''
                        aws sts get-caller-identity
                    '''
                }
            }
        }

        stage('ECS Update') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id']
                ]) {
                    sh """
                        chmod +x ./scripts/ecs.sh
                        ./scripts/ecs.sh ${params.ACTION}
                    """
                }
            }
        }
    }

    post {

        always {
            cleanWs()
        }

        success {
            echo "ECS operation completed successfully."
        }

        failure {
            echo "ECS operation failed."
        }
    }
}
