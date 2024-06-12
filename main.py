import os
import json
import uuid
from flask import Flask, render_template_string

app = Flask(__name__)

@app.route('/')
def home():
    new_uuid = str(uuid.uuid4())
    vmess_link = f"vmess://{{\"v\":\"2\",\"ps\":\"my_v2ray\",\"add\":\"{os.getenv('RENDER_EXTERNAL_HOSTNAME')}\",\"port\":\"443\",\"id\":\"{new_uuid}\",\"aid\":\"64\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"\",\"path\":\"/vmess\",\"tls\":\"\"}}"
    
    # 更新配置文件
    config_path = '/etc/v2ray/config.json'
    with open(config_path, 'r') as f:
        config = json.load(f)
    
    config['inbounds'][0]['settings']['clients'][0]['id'] = new_uuid
    
    with open(config_path, 'w') as f:
        json.dump(config, f, indent=2)
    
    return render_template_string('''
        <!DOCTYPE html>
        <html>
        <head>
            <title>V2Ray VMess Link</title>
        </head>
        <body>
            <h1>Your V2Ray VMess Link</h1>
            <a href="{{ vmess_link }}">{{ vmess_link }}</a>
        </body>
        </html>
    ''', vmess_link=vmess_link)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
