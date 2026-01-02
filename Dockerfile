# 使用 Node.js 20 轻量版作为基础
FROM node:20-slim

# 1. 安装基础工具、Cloudflared 隧道客户端、Filen 客户端
# 我们把所有安装命令合并，减少镜像体积
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb && \
    npm install -g @filen/cli

# 设置端口 (虽然走隧道不需要对外暴露端口，但保留它是好习惯)
ENV PORT=5244

# 2. 启动命令 (最关键的部分)
# 解释：先在后台启动 Filen 服务 (&)，然后启动 Cloudflare Tunnel 连接外网
CMD (filen webdav --email "$FILEN_EMAIL" --password "$FILEN_PASSWORD" --w-user "$WEBDAV_USER" --w-password "$WEBDAV_PASS" --w-port 5244 --w-hostname 0.0.0.0 &) && cloudflared tunnel run --token "$TUNNEL_TOKEN"
