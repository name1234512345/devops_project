FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
RUN ls -l /tmp
FROM openjdk:21-jdk-slim
WORKDIR /app
RUN apt update && apt install -y maven
COPY --from=build /tmp/target/*.jar service1_application.jar
COPY --from=build . /app
ENTRYPOINT ["java","-jar","service1_application.jar"]
EXPOSE 9090
