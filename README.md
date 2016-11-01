# 使用docker搭建PHP开发环境

## 目录和文件说明

- apps 自定义的应用镜像目录
- config 本地的一些自定义配置
- data 数据目录，用来存放持久化的数据，如 mysql 的数据文件
- htdocs web程序代码目录
- logs 日志目录，用来保存 nginx、php 等应用产生的日志

## 启动

前台运行：

```bash
$ docker-compose up
```

后台运行：

```bash
$ docker-compose up -d
```

关闭：

```bash
$ docker-compose down
```

