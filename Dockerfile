# Sử dụng hình ảnh Ubuntu làm cơ sở
FROM ubuntu:latest AS build

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Thiết lập biến môi trường
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Sao chép mã nguồn của ứng dụng vào trong image
COPY . /src

# Đặt thư mục làm việc hiện tại
WORKDIR /src

# Xây dựng ứng dụng bằng Gradle
RUN ./gradlew --no-daemon bootJar

# Sao chép tệp JAR đã xây dựng vào trong image
COPY --from=build /app/build/libs/*.jar app.jar

# Mở cổng 8080 để giao tiếp với ứng dụng Spring Boot
EXPOSE 8080

# Chạy ứng dụng khi container được khởi chạy
CMD ["java", "-jar", "app.jar"]
