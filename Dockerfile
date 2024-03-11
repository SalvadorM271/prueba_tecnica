FROM maven:3.8.4-openjdk-17-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project file
COPY ./.mvn ./.mvn
COPY mvnw pom.xml ./

#install dpendencies
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src src

RUN apt-get update && apt-get install -y inotify-tools

# Expose the port your application will run on
EXPOSE 8080

CMD ["./mvnw", "spring-boot:run"]