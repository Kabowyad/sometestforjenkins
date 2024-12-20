# Use a multi-stage build to keep the final image lightweight
FROM maven:3.6.3 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime for the final image
FROM anapsix/alpine-java

# Copy the jar file from the build stage
COPY --from=build /app/target/* /home/my-app.jar

# Command to run the application
CMD ["java", "-jar", "/home/my-app.jar"]
