FROM alpine:latest

# 安装必要的软件包
RUN apk update && apk add --no-cache python3 py3-pip wget unzip

# 下载并安装V2Ray
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip -d /usr/local/bin && \
    rm v2ray-linux-64.zip

# 复制配置文件和应用文件
COPY config.json /etc/v2ray/config.json
COPY main.py /app/main.py

# 设置工作目录
WORKDIR /app

# 暴露端口
EXPOSE 443

# 启动V2Ray和Python脚本
CMD ["sh", "-c", "v2ray -config /etc/v2ray/config.json & python3 /app/main.py"]
