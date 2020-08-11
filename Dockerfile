FROM tomcat:alpine
MAINTAINER AbhigoyalDev
RUN wget -O /usr/local/tomcat/webapps/launchstation04.war http://localhost:8082/artifactory/libs-snapshot-local/com/mycompany/app/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
