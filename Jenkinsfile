pipeline
{
    agent any
	tools
	{
		maven 'Maven3'
	}
	options
    {
        // Append time stamp to the console output.
        timestamps()
      
        timeout(time: 1, unit: 'HOURS')
      
        // Do not automatically checkout the SCM on every stage. We stash what
        // we need to save time.
        skipDefaultCheckout()
      
        // Discard old builds after 10 days or 30 builds count.
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '10'))
	  
	    //To avoid concurrent builds to avoid multiple checkouts
	    disableConcurrentBuilds()
    }
    stages
    {    	
	    stage ('checkout')
		{
			steps
			{
				echo "hello! I'm in development environment."
				checkout scm
			}
		}
		stage ('Build')
		{
			steps
			{
				bat "mvn clean install"
			}
		}
		stage ('Unit Testing')
		{
			steps
			{
				bat "mvn test"
			}
		}
		/*stage ('Sonar Analysis')
		{
			steps
			{
				withSonarQubeEnv("Test_Sonar") 
				{
					bat "mvn sonar:sonar"
				}
			}
		}
	    	stage('Upload to Artifactory') {
			steps {
				rtMavenDeployer(
					id: 'deployer',
					serverId: '123456789@artifactory',
					releaseRepo: 'abhigoyal_release',
					snapshotRepo: 'abhigoyal_snapshot'
				)
				rtMavenRun(
					pom: 'pom.xml',
					goals: 'clean install',
					deployerId: 'deployer',
				)
				rtPublishBuildInfo(
					serverId: '123456789@artifactory',
				)
			}
		}
	    	stage('Docker Image') {
			steps {
				bat returnStdout: true, script: 'docker build -t dtr.nagarro.com:443/my-app:%BUILD_NUMBER% -f Dockerfile .'
			}
		}

		stage('Docker Containers'){
            parallel{
                stage('PreRunningContainer Check'){
                    steps{
			            script{
				            containerId = powershell(script:'docker ps --filter name=c-my-app --format "{{.ID}}"', returnStdout:true, label:'')
				            echo "containerid: ${containerId}"
				            if(containerId){
					            bat "docker stop ${containerId}"
					            bat "docker rm -f ${containerId}"
				            }
			            }   
                    }
                }

                stage('Push Image to DTR'){
                    steps{
			            bat returnStdout: true, script: 'docker push dtr.nagarro.com:443/my-app:%BUILD_NUMBER%'
                    }
                }
            }    
        }*/




	    	/*stage ('Push to DTR') {			
			steps{	
				withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
					bat returnStdout: true, script: "docker login -u abhigoyaldev -p ${dockerHubPwd}"
				}
				bat returnStdout: true, script: 'docker push dtr.nagarro.com:443/my-app:%BUILD_NUMBER%'
			}
		}
	    	stage('Stop Running container') {
			steps {
				bat '''@echo off for / f "tokens=*" % % my-app in ('docker ps -q --filter "name=dtr.nagarro.com:443/my-app"') do docker stop % % my-app && docker rm --force % % my-app || exit / b 0 '''
			}
		}*/
	    	stage('Docker deployment') {
			steps {
				bat returnStdout: true, script: 'docker run --name c-my-app -d -p 7000:8080 dtr.nagarro.com:443/my-app:%BUILD_NUMBER%'
			}
		}
	    stage('helm deployment') {
		    steps {
			    script{
			    	namespaceName = powershell(script:"kubectl get ns --field-selector metadata.name=abh", returnStdout:true, label:'')
				    echo "namespaceName: ${namespaceName}"
				    if(namespaceName){
					    bat "kubectl delete ns ${namespaceName}"
				    }
		    		bat 'kubectl create ns abh'
		    		bat 'helm install app-deployment my-chart --set image=dtr.nagarro.com:443/my-app:%BUILD_NUMBER% -n abh'
			    }
		    }
		}
    }
    /*post {
		always {
			emailext attachmentsPattern: 'report.html', body: '${JELLY_SCRIPT,template="health"}', mimeType: 'text/html', recipientProviders: [
				[$class: 'RequesterRecipientProvider']
			], replyTo: 'abhishek.goyal@nagarro.com', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'abhishek.goyal@nagarro.com'
		}
	}*/	
}
