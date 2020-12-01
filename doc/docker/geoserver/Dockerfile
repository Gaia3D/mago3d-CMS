FROM tomcat:9.0.38-jdk11-adoptopenjdk-openj9

ENV JAVA_OPTS=-D-Xms4096m-Xmx4096m
#ENV GEOSERVER_DATA_DIR=/geoserver-data

RUN \
    apt-get update && \
    apt-get install -y vim wget unzip && \
    rm -rf /usr/local/tomcat/webapps/* && \
    cd /tmp && wget https://sourceforge.net/projects/geoserver/files/GeoServer/2.17.3/geoserver-2.17.3-war.zip/download && \
    unzip /tmp/download -d /usr/local/tomcat/webapps && \
    rm -rf /tmp/download

# Enable CORS
RUN sed -i '\:</web-app>:i\
<filter>\n\
    <filter-name>CorsFilter</filter-name>\n\
    <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>\n\
    <init-param>\n\
        <param-name>cors.allowed.origins</param-name>\n\
        <param-value>*</param-value>\n\
    </init-param>\n\
    <init-param>\n\
        <param-name>cors.allowed.methods</param-name>\n\
        <param-value>GET,POST,HEAD,OPTIONS,PUT</param-value>\n\
    </init-param>\n\
</filter>\n\
<filter-mapping>\n\
    <filter-name>CorsFilter</filter-name>\n\
    <url-pattern>/*</url-pattern>\n\
</filter-mapping>' /usr/local/tomcat/conf/web.xml

