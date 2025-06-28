# Use Amazon Corretto JDK 21
FROM amazoncorretto:21

# Set working directory
WORKDIR /app

# Copy your Spring Boot JAR into the container
COPY target/*.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
