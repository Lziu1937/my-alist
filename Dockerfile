# 使用最稳的 Node.js 镜像（自带 shell，自带安装工具）
FROM node:20-slim

# 安装 Filen 官方客户端
RUN npm install -g @filen/cli

# 设置端口
ENV PORT=5244
EXPOSE 5244

# 启动命令（直接调用安装好的 filen）
CMD filen webdav --email "$FILEN_EMAIL" --password "$FILEN_PASSWORD" --w-user "$WEBDAV_USER" --w-password "$WEBDAV_PASS" --w-port 5244 --w-hostname 0.0.0.0
