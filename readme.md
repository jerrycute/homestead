# homestead 安装与使用（Windows）

## 简略步骤
* 安装 VirtualBox
* 安装 Vagrant
* 导入 Homestead Box 虚拟机盒子
* 安装 Git
* 安装 Homestead 管理脚本
* 配置 Homestead.yaml 文件
* 启动 Homestead 虚拟机


### 1、安装VirtualBox
下载安装 https://www.virtualbox.org/wiki/Downloads

### 2、安装vagrant
下载安装 https://releases.hashicorp.com/vagrant/2.2.0/vagrant_2.2.0_x86_64.msi

### 3、下载homestead 盒子
下载并解压到一个非中文目录，http://download.fsdhub.com/lc-homestead-6.1.1-2018090400.zip

### 4、vagrant 添加homestead 盒子
运行命令
```
$ cd /e/virtualbox/homestead-box/
$ cp metadata.json metadata-work-8888.json &&  sed  -ir 's#"name": "(.*)/homestead",#"name":"work8888/homestead",#' metadata-work-8888.json
$ vagrant box add metadata.json
$ vagrant box list
```

### 5、下载安装windows 版 git图形端
下载安装 https://gitforwindows.org/


### 6、安装homestead

用 git_bash 图形端打开，切换到家目录  

```
$ cd ~

# 下载文件
$ git clone https://gitee.com/cutejerry/homestead.git
```


### 生成 ssh key（如果已生成，跳过此步骤）
```
# 一路回车
$ ssh-keygen -t rsa -C "your_email@example.com"

# 检验是否生成，SSH 秘钥的两个文件
    1、id_rsa —— SSH 秘钥的 私钥 (Private Key)
    2、id_rsa.pub —— SSH 秘钥的 公钥 (Public Key)
$ ls -la ~/.ssh
```



### 配置文件
```
$ cd ~/Homestead
$ cp Homestead.yaml.example Homestead.yaml
```


### 配置后启动
```
$ cd ~/Homestead && vagrant up
```

### 进入虚拟机

```
$ vagrant ssh
```


### vagrant 常用命令
```
vagrant init    初始化 vagrant
vagrant up    启动 vagrant
vagrant halt    关闭 vagrant
vagrant ssh    通过 SSH 登录 vagrant（需要先启动 vagrant）
vagrant provision    重新应用更改 vagrant 配置
vagrant destroy    删除 vagrant
```




## 文档参考

### windows 环境搭建homestead

https://laravel-china.org/docs/laravel-development-environment/5.5/development-environment-windows/938



### 解决 Windows 系统使用 Homestead 运行 Laravel 本地项目响应缓慢问题
https://laravel-china.org/articles/9009/solving-the-slow-response-problem-of-the-windows-system-using-homestead-to-run-laravel-project




