FROM ubuntu:14.04
WORKDIR /root

RUN apt-get update && apt-get install -y software-properties-common

RUN apt-get update && apt-get install -y \
  openjdk-7-jdk \
  git \
  openssh-server \
  curl \
  && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

ADD run.sh /run.sh
RUN chmod +x /run.sh
