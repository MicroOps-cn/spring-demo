FROM maven:3.8.6-openjdk-8-slim as builder
WORKDIR /src/
ADD pom.xml /src/
RUN mvn prepare-package
RUN mvn dependency:resolve-plugins

ADD . /src/
RUN mvn package -Dmaven.test.skip=true


FROM openjdk:8-jre-slim-buster
COPY --from=builder /src/target/demo-0.0.1-SNAPSHOT.jar /opt/demo/demo-0.0.1-SNAPSHOT.jar
CMD ["java","-server","-jar","/opt/demo/demo-0.0.1-SNAPSHOT.jar"]