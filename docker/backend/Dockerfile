# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim as build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and POM file to the container
COPY .mvn/ .mvn/
COPY mvnw .
COPY pom.xml .

# Install Maven dependencies
RUN ./mvnw dependency:go-offline

# Copy the entire source code into the container
COPY src ./src

# Build the application
RUN ./mvnw package -DskipTests

# Use a lightweight image to run the application
FROM openjdk:17-jre-slim

# Set the working directory for the runtime image
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Set the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose the port that your application runs on
EXPOSE 8080
