FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-17-jdk
WORKDIR /app
COPY . /src
RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-jdk-slim
EXPOSE 8080

COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
