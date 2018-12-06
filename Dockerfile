# Stage 1
FROM maven:3-jdk-11-slim as builder

WORKDIR /myapp
COPY pom.xml .
COPY src/ ./src/

RUN mvn package

# Stage 2
FROM arm32v7/openjdk:11-jre-slim

WORKDIR /myapp
COPY --from=builder /myapp/target/*.jar ./app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "./app.jar"]
