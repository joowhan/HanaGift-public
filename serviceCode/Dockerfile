# 1. 베이스 이미지 선택: OpenJDK 17을 사용하는 이미지 사용
FROM openjdk:17-jdk-slim

# 2. 애플리케이션 WAR 파일을 컨테이너에 복사
# 'hanagift-0.0.1-SNAPSHOT.war'은 실제 빌드된 WAR 파일의 이름
COPY build/libs/hanagift-0.0.1-SNAPSHOT.war /app/hanagift.war

# 3. 컨테이너 내에서 애플리케이션 실행
# 내장 톰캣을 사용하여 Spring Boot 애플리케이션을 실행
CMD ["java", "-jar", "/app/hanagift.war"]
