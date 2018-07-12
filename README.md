# codeforfun-MicroService

#### 项目介绍

基于SpringCloud/Docker微服务Demo

#### 软件架构

软件架构说明

```
graph LR
业务模块 --> Nginx

Nginx --> 前端
Nginx --> 后端路由

后端路由-->注册中心

注册中心-->服务1
注册中心-->服务2

服务1-->数据库
服务2-->数据库
```



```
graph LR

持续集成 -->官方支持的镜像
持续集成 -->自己制作的镜像

自己制作的镜像-->阿里云打包镜像

阿里云打包镜像-->Jenkins
官方支持的镜像-->Jenkins

Jenkins-->启动

```

#### 安装教程

```bash
git pull https://github.com/qq253498229/codeforfun-microservice.git
cd codeforfun-microservice
docker-compose up -d
```

> 之后可以访问[http://localhost](http://localhost) 测试效果

#### 使用说明

- [点击](https://github.com/qq253498229/codeforfun-docs) 查看设计文档
- nginx/Shell/docker/jenkins整合请参考本模块
- [点击](https://github.com/qq253498229/codeforfun-front-pc) 查看前端源码



#### 参与贡献

1. Fork 本项目
2. 新建 Feature_xxx 分支
3. 提交代码
4. 新建 Pull Request

