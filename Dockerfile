FROM v2fly/v2fly-core

COPY config.json /etc/v2ray/config.json
COPY main.py /app/main.py
COPY requirements.txt /app/requirements.txt

WORKDIR /app

RUN apk add --no-cache python3 py3-pip && \
    pip3 install -r requirements.txt

EXPOSE 443

CMD ["sh", "-c", "v2ray -config /etc/v2ray/config.json & python3 /app/main.py"]
