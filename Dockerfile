FROM tomcat:alpine
MAINTAINER DevOps Team
COPY target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
