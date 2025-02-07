FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /tmp
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
RUN ls -l /tmp
FROM openjdk:21-jdk-slim
WORKDIR /tmp
COPY --from=build /tmp/target/*.jar service1_application.jar
ENTRYPOINT ["java","-jar","service1_application.jar"] 
EXPOSE 9090
