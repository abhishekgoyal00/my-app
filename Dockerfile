FROM tomcat:alpine
MAINTAINER AbhigoyalDev
RUN wget -O /usr/local/tomcat/webapps/launchstation04.war /target/*.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
