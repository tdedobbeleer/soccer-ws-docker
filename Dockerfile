FROM eclipse-temurin:latest

ARG RELEASE=1.0.1

COPY ./target/soccer-ws.jar /usr/app/soccer-ws.jar

RUN adduser --disabled-login --disabled-password --gecos "" javauser
USER javauser

ENTRYPOINT ["java", "-Xss512K","-XX:CICompilerCount=2","-Dfile.encoding=UTF-8","-XX:+UseContainerSupport","-Djava.security.egd=file:/dev/./urandom", "-jar","/usr/app/soccer-ws.jar", "--spring.profiles.active=${SPRING_PROFILES_ACTIVE:-local}"]
