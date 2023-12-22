# Use a minimal base image for the runtime
FROM eclipse-temurin:17

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY /target/mavenforjenkins-0.0.1-SNAPSHOT.jar .

# Expose the port your application will run on
EXPOSE 8090

# Specify the command to run your application
CMD ["java", "-jar", "mavenforjenkins-0.0.1-SNAPSHOT.jar"]
