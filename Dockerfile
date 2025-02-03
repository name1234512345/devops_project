FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /tmp
COPY service2/pom.xml .
COPY service2/src ./src
RUN mvn clean package -DskipTests
RUN ls -l /tmp
FROM openjdk:21-jdk-slim
WORKDIR /tmp
COPY --from=build /tmp/target/*.jar service2_application.jar
ENTRYPOINT ["java","-jar","service2_application.jar"] CMD ["-start"]
EXPOSE 8080