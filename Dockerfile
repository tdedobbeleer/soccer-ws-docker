FROM eclipse-temurin:latest

COPY ./${VERSION}.jar /usr/app/${VERSION}.jar

RUN adduser --disabled-login --disabled-password --gecos "" javauser
USER javauser

ENTRYPOINT ["java", "-Xss512K","-XX:CICompilerCount=2","-Dfile.encoding=UTF-8","-XX:+UseContainerSupport","-Djava.security.egd=file:/dev/./urandom", "-jar","/usr/app/app.jar", "--spring.profiles.active=${SPRING_PROFILES_ACTIVE}"]
