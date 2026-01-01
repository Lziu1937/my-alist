# 第一步：从官方镜像里把 filen 程序偷出来
FROM filen/cli:latest AS source

# 第二步：换一个有“大脑”（有 shell）的系统
FROM ubuntu:22.04

# 安装必要的运行库（Filen 需要这些才能跑）
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# 把刚才偷出来的 filen 程序放到新系统里
COPY --from=source /usr/local/bin/filen /usr/local/bin/filen

# 赋予运行权限
RUN chmod +x /usr/local/bin/filen

# 设置端口
ENV PORT=5244

# 启动命令（这次有 shell 了，绝对能识别你的变量）
ENTRYPOINT []
CMD filen --email $FILEN_EMAIL --password $FILEN_PASSWORD webdav --w-user $WEBDAV_USER --w-password $WEBDAV_PASS --w-port 5244 --w-hostname 0.0.0.0
