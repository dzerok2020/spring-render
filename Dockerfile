# Sử dụng hình ảnh Ubuntu làm cơ sở
FROM ubuntu:latest

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Thiết lập biến môi trường
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Sao chép mã nguồn của ứng dụng vào trong image
COPY . /app

# Đặt thư mục làm việc hiện tại
WORKDIR /app

# Xây dựng ứng dụng bằng Gradle
RUN ./gradlew bootJar --no-daemon

# Sao chép tệp JAR đã xây dựng vào trong image
COPY build/libs/*.jar app.jar

# Mở cổng 8080 để giao tiếp với ứng dụng Spring Boot
EXPOSE 8080

# Chạy ứng dụng khi container được khởi chạy
CMD ["java", "-jar", "app.jar"]
