FROM ubuntu:14.04
WORKDIR /tmp

RUN apt-get update && apt-get install -y software-properties-common \
  && apt-add-repository ppa:brightbox/ruby-ng

RUN apt-get update && apt-get install -y \
  openjdk-7-jdk \
  git \
  openssh-server \
  curl \
  s3cmd \
  build-essential \
  patch \
  libmagic-dev=1:5.14-2ubuntu3.3 \
  zlib1g-dev=1:1.2.8.dfsg-1ubuntu1 \
  ruby2.2 \
  ruby2.2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN gem update && gem install \
  nokogiri:1.6.7.2 \
  bundler:1.11.2 \
  pdd:0.15.4 \
  est:0.3.1

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

ADD run.sh /run.sh
RUN chmod +x /run.sh
