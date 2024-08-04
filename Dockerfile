# Stage 1: Build the application
FROM maven:3.8.1-openjdk-17-slim AS MAVEN_BUILD

# Create the directory for source files
RUN mkdir /sources

# Copy project files to the container
COPY ./ /sources

# Build the application's JAR
RUN echo "Building app..." && cd /sources && mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-oracle

# Set the working directory
WORKDIR /app

# Copy the JAR built from the previous stage
COPY --from=MAVEN_BUILD /sources/target/camunda-spring-boot-1.0.0-SNAPSHOT.jar /app/camunda-spring-boot-1.0.0-SNAPSHOT.jar

# Expose the port on which the application runs
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "camunda-spring-boot-1.0.0-SNAPSHOT.jar"]
