import os

def display_vmess_link():
    vmess_link = f"vmess://{{\"v\":\"2\",\"ps\":\"my_v2ray\",\"add\":\"{os.getenv('RENDER_EXTERNAL_HOSTNAME')}\",\"port\":\"443\",\"id\":\"your_uuid_here\",\"aid\":\"64\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"\",\"path\":\"/vmess\",\"tls\":\"\"}}"
    print(f"Your V2Ray VMess Link: {vmess_link}")

if __name__ == "__main__":
    display_vmess_link()
