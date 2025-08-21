# 打包镜像
# ---------- 阶段 1：构建 ----------
FROM node:18-alpine AS builder
WORKDIR /app
# 先复制依赖文件，利用缓存
COPY package*.json ./
RUN npm ci --only=production && npm install -g hexo-cli
# 再复制源码
COPY . .
# 生成静态文件
RUN hexo clean && hexo generate
    
# # ---------- 阶段 2：运行 ----------
FROM nginx:alpine
# 把上一步生成的 public 拷到 Nginx 默认目录
COPY --from=builder /app/public /usr/share/nginx/html
# 可选：自定义 Nginx 配置
# COPY nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80 #初始为80（打包镜像暴露的端口号即为80）

# 验证发现：无论该值为多少打包的镜像暴露端口都是80
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]