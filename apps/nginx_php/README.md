# 说明文档

这个镜像整合了nginx+php5.6+supervisor，supervisor用来管理php-fpm和nginx进程。

## 配置文件

- nginx主配置文件: /etc/nginx/nginx.conf
- php配置文件: /usr/local/etc/php.ini
- php配置扫描目录: /usr/local/etc/conf.d
- fpm配置文件: /usr/local/etc/php-fpm.conf 

## 数据目录

- web代码目录: /data/htdocs
- 日志目录: /data/logs

## 编译

```bash
$ docker build nginx_php apps/nginx_php/
```

## 启动

```bash
$ docker run -p 8000:80 -v /data/htdocs:/data/htdocs -v /data/logs:/data/logs nginx_php
```

参数说明：

* -p 8000:80 将容器的80端口映射到本机的8000端口
* -v /data/htdocs:/data/htdocs 将本机的 /data/htdocs 目录挂载到容器的 /data/htdocs 目录

最后打开浏览器访问 http://localhost:8000