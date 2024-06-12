FROM alpine:latest

# 安装必要的软件包
RUN apk update && \
    apk add --no-cache python3 py3-pip

# 安装V2Ray
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip -d /usr/local/bin && \
    rm v2ray-linux-64.zip

# 复制配置文件和应用文件
COPY config.json /etc/v2ray/config.json
COPY main.py /app/main.py
COPY requirements.txt /app/requirements.txt

WORKDIR /app

# 安装Python依赖
RUN pip3 install -r requirements.txt

# 暴露端口
EXPOSE 443
EXPOSE 8000

CMD ["sh", "-c", "v2ray -config /etc/v2ray/config.json & python3 /app/main.py"]
