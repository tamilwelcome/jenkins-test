pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/tamilwelcome/jenkins-test.git'
            }
        }
        stage('dockerbuild') {
            steps {
                sh 'docker build -t nodered:1.19 .'
                sh 'docker tag nodered:1.19 igate-ivpn.iplon.co.in:8080/test/nodered:1.19'
            }
        }
        stage('docker push') {
            steps {
                sh 'docker login igate-ivpn.iplon.co.in:8080 -u admin -p iplon321'
                sh 'docker push igate-ivpn.iplon.co.in:8080/test/nodered:1.19'
            }
        }
        stage('tunnel ip adding') {
            steps {
                sh 'docker cp /var/lib/jenkins/workspace/docker/hosts ansible:/etc/ansible/'
            }
        }
        stage('docker-compose') {
            steps {
                sh 'docker cp /var/lib/jenkins/workspace/docker/docker-compose.yaml ansible:/etc/ansible/ccra_project'
            }
        }
        stage('ansible-ping') {
            steps {
                sh 'docker exec ansible /bin/bash -c "cd /etc/ansible/ && ansible all -m ping"'
            }
        }
        stage('install ansible package') {
            steps {
                sh 'docker exec ansible /bin/bash -c "cd /etc/ansible/ && ansible-playbook ccra.yaml"'
            }
        }
    }
}
