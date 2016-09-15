FROM ubuntu:14.04
WORKDIR /root

# UTF-8 locale
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y software-properties-common sudo build-essential
RUN sudo add-apt-repository ppa:webupd8team/java
RUN apt-get update && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java8-installer git curl openssh-server \
  && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV TERMINAL linux
ENV TERM linux
ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
WORKDIR /
RUN wget http://www-eu.apache.org/dist/hbase/1.2.3/hbase-1.2.3-bin.tar.gz && tar xfz hbase-1.2.3-bin.tar.gz && mv /hbase-1.2.3 /app

# SSH-KEYS
ADD /ssh /root/.ssh
RUN chmod 400 /root/.ssh/*

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/bin/bash", "-l", "/run.sh"]
