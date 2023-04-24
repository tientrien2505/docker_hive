FROM ubuntu:22.04

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y openjdk-11-jre-headless

ENV HADOOP_HOME=/opt/hadoop-3.2.1
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

COPY apache-hive-metastore-3.1.2-bin /opt/metastore/
COPY hadoop-3.2.1 /opt/hadoop-3.2.1/

RUN rm -f /opt/metastore/lib/guava-19.0.jar \
  && cp ${HADOOP_HOME}/share/hadoop/common/lib/guava-27.0-jre.jar /opt/metastore/lib \
  && cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.1.jar /opt/metastore/lib \
  && cp ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar /opt/metastore/lib


CMD ["/opt/metastore/bin/start-metastore"]
