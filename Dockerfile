FROM n3ziniuka5/ubuntu-oracle-jdk:14.10-JDK7u80
MAINTAINER "Priyaranjan Dash" "priyaranjan.dash@mindtree.com"
ADD /opt/installs/jboss-eap-6.1.0.zip /opt/jboss-eap-6.1.0.zip
RUN unzip /opt/jboss-eap-6.1.0.zip
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/bin
ENV JBOSS_HOME /opt/jboss-eap-6.1
RUN $JBOSS_HOME/bin/add-user.sh admin admin123% --silent
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\""
        >> $JBOSS_HOME/bin/standalone.conf
ADD /opt/artifacts/aegbt.war /opt/jboss-eap-6.1/standalone/deployments
ADD /opt/artifacts/jsphello1.war /opt/jboss-eap-6.1/standalone/deployments
RUN touch /opt/jboss-eap-6.1/standalone/deployments/aegbt.war.dodeploy
RUN touch /opt/jboss-eap-6.1/standalone/deployments/jsphello1.war.dodeploy
EXPOSE 8080 9990 9999
ENTRYPOINT $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml
