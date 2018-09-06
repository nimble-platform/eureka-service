node ('nimble-jenkins-slave') {
    stage('Download Latest') {
        git(url: 'https://github.com/nimble-platform/eureka-service.git', branch: 'master')
    }

    stage ('Build & Push docker image') {
        sh 'docker build -t nimbleplatform/eureka-service:${BUILD_NUMBER} .'
        withDockerRegistry([credentialsId: 'NimbleDocker']) {
            sh 'docker push nimbleplatform/eureka-service:${BUILD_NUMBER}'
        }
    }

    stage ('Deploy and print logs') {
        sh ''' sed -i 's/IMAGE_TAG/'"$BUILD_NUMBER"'/g' deploy.yaml '''
        sh 'kubectl apply -f deploy.yaml -n prod --validate=false'
        sh 'kubectl apply -f svc.yaml -n prod --validate=false'
        sh 'sleep 60'
        sh 'kubectl -n prod logs deploy/eureka-service -c eureka-service'
    }
}