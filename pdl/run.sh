ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
echo -e 'Host localhost *\n\tStrictHostKeyChecking no\n' >> ~/.ssh/config
sudo service ssh start

if [ -e settings.xml ]; then
  export MAVEN_OPTS=-Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
  mvn clean install -B -Pqulice --settings settings.xml
  mvn clean
fi
