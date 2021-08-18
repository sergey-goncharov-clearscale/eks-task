// version 1.0

def docker_registry = "svg1007/code_php"
def service_version = "0.0.5"

pipeline {
    agent any

    stages {
        stage('Build docker image') {
            steps {
                script {
                    dir("$WORKSPACE/code") {
                        sh "docker build -t ${docker_registry}:${service_version} ."
                        sh "docker push ${docker_registry}:${service_version}"
                    }
                }
            }
        }
        stage('Deploy by helm') {
            steps {
                script {
                    dir("$WORKSPACE/helm/php") {
                        sh "helm ssm upgrade php -f values.tf"
                    }
                }
            }
        }
    post {
        always {
            script {
                cleanWs()
            }
        }
    }
}
