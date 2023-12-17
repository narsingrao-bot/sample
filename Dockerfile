# Use a minimal base image for the runtime
FROM eclipse-temurin:11

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY mavenforjenkins-0.0.1-SNAPSHOT.jar .

# Specify the command to run your application
CMD ["java", "-jar", "mavenforjenkins-0.0.1-SNAPSHOT.jar"]
