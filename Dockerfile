FROM tomcat:alpine
MAINTAINER AbhigoyalDev
RUN wget -O http://localhost:8082/artifactory/libs-snapshot-local/com/mycompany/app/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/launchstation04.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
