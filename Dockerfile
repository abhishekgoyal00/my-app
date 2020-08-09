FROM tomcat:alpine
MAINTAINER AbhigoyalDev
RUN wget -O /usr/local/tomcat/webapps/launchstation04.war C:/WINDOWS/system32/config/systemprofile/AppData/Local/Jenkins.jenkins/workspace/PipelineDemo/target/*.war
EXPOSE 8938
CMD /usr/local/tomcat/bin/catalina.sh run
