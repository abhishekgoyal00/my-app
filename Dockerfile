FROM tomcat:alpine
MAINTAINER AbhigoyalDev
COPY target/*.war /usr/local/tomcat/webapps/launchstation04.war
RUN wget -O /usr/local/tomcat/webapps/launchstation04.war C:/WINDOWS/system32/config/systemprofile/AppData/Local/Jenkins.jenkins/workspace/PipelineDemo/target/*.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
