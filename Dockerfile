FROM tomcat:alpine
MAINTAINER DevOps Team
/*RUN wget -O /usr/local/tomcat/webapps/launchstation04.war target/*.war */
COPY target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
