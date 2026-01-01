# 使用 Filen 官方镜像
FROM filen/cli:latest

# 设置 Render 必需的端口变量
ENV PORT=5244

# 启动 Filen WebDAV 服务
# 这里使用了变量，等下在 Render 后台填入
CMD ["sh", "-c", "filen --email $FILEN_EMAIL --password $FILEN_PASSWORD webdav --w-user $WEBDAV_USER --w-password $WEBDAV_PASS --w-port 5244 --w-hostname 0.0.0.0"]
