FROM jenkins

USER root
ENV JENKINS_VERSION=2.121.3

# download latest jenkins war
RUN apt-get update && apt-get install axel libltdl7 -y && rm -rf /var/lib/apt/lists/*
RUN axel http://mirrors.jenkins.io/war-stable/${JENKINS_VERSION}/jenkins.war
RUN mv ./jenkins.war /usr/share/jenkins && chmod 777 /usr/share/jenkins/jenkins.war

# Add Jenkins plugins
#COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt