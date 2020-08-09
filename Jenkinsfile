pipeline
{
    agent any
	tools
	{
		maven 'Maven'
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
		stage ('Sonar Analysis')
		{
			steps
			{
				withSonarQubeEnv("SonarQube") 
				{
					bat "mvn sonar:sonar"
				}
			}
		}
	    	stage('Docker Image') {
			steps {
				bat returnStdout: true, script: 'docker build -t abhigoyaldev/my-app:%BUILD_NUMBER% -f Dockerfile .'
			}
		}
	    	stage ('Push to DTR') {
			withCredentials([string(credentialsId: 'afc010dc-d949-4f07-9cff-9f69a6c4158c', variable: 'dockerHubPwd')]) {
				bat returnStdout: true, script: 'docker login -u abhigoyaldev -p ${dockerHubPwd}'
			}
			steps{				
				bat returnStdout: true, script: 'docker push abhigoyaldev/my-app:%BUILD_NUMBER%'
			}
		}
    }
}
