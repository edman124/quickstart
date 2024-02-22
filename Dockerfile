# ---BUILD MVN IN IMAGE---
# FROM maven:alpine as build

# ENV HOME=/usr/quickstart
# RUN mkdir -p $HOME
# WORKDIR $HOME
# COPY . .
# WORKDIR $HOME/flink-connector-kafka
# RUN mvn clean install -DskipTests
# WORKDIR $HOME
# RUN mvn clean package -Denforcer.skip=true -DskipTests=true

# FROM flink:1.17
# COPY --from=build /usr/quickstart/flink-connector-kafka/flink-connector-kafka-e2e-tests/flink-streaming-kafka-test/target/KafkaExample.jar /opt/flink/usrlib/KafkaExample.jar
# RUN java -jar /opt/flink/usrlib/KafkaExample.jar --input-topic test-input --output-topic test-output --bootstrap.servers localhost:9092 --group.id myconsumer


#---COPY FROM IMAGE---
# FROM flink:1.17
# RUN mkdir /opt/flink/usrlib
# COPY --from=build /usr/quickstart/target/quickstart-0.1.jar /opt/flink/usrlib/quickstart-0.1.jar 
# RUN java -cp /opt/flink/usrlib/quickstart-0.1.jar org.myorg.quickstart.DataStreamJob
# RUN chown -R flink:flink /opt/flink


# ---BASE: COPY JAR DIRECTLY---
FROM flink:1.17

RUN mkdir /opt/flink/usrlib
ADD target/quickstart-0.1.jar /opt/flink/usrlib/quickstart-0.1.jar
RUN chown -R flink:flink /opt/flink