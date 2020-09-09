FROM tomcat:alpine
MAINTAINER abhishekgoyal
RUN rm -fr /usr/local/tomcat/webapps/launchstation04.war
COPY target/*.war /usr/local/tomcat/webapps/launchstation04.war
EXPOSE 80
CMD /usr/local/tomcat/bin/catalina.sh run
