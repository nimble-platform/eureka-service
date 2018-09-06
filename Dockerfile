FROM netflixoss/tomcat:7.0.64
MAINTAINER Netflix Open Source Development <talent@netflix.com>

RUN cd /tomcat/webapps &&\
  mkdir eureka &&\
  cd eureka &&\
  wget -q http://repo1.maven.org/maven2/com/netflix/eureka/eureka-server/1.3.1/eureka-server-1.3.1.war &&\
  jar xf eureka-server-1.3.1.war &&\
  rm eureka-server-1.3.1.war

ADD config.properties /tomcat/webapps/eureka/WEB-INF/classes/config.properties
ADD eureka-client.properties /tomcat/webapps/eureka/WEB-INF/classes/eureka-client-prod.properties
ADD eureka-server.properties /tomcat/webapps/eureka/WEB-INF/classes/eureka-server-prod.properties

ENTRYPOINT ["/tomcat/bin/catalina.sh"]

CMD ["run"]