FROM amazoncorretto:latest

ARG JAR

RUN mkdir /usr/app 
RUN echo $JAR > /usr/app/release.info

COPY ./$JAR /usr/app/soccer-ws.jar

RUN adduser --disabled-login --disabled-password --gecos "" javauser
USER javauser

ENTRYPOINT ["java", "-Xss512K","-XX:CICompilerCount=2","-Dfile.encoding=UTF-8","-XX:+UseContainerSupport","-Djava.security.egd=file:/dev/./urandom", "-jar","/usr/app/soccer-ws.jar", "--spring.profiles.active=${SPRING_PROFILES_ACTIVE:-local}"]
