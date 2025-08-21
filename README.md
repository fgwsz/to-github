# to-github
如何连接到`github.com`  
## 辅助加速器
`PC`端:`Edge`应用商店`SetupVPN`  
移动端:任意免费加速器  
## 安装`git`
使用如下命令安装`git`  
```bash
sudo apt-get install git
git --version
```
## 配置`GitHub`帐号信息
使用辅助加速器在网页加速之后,
登录`github.com`注册帐号.  
将`GitHub`帐号信息配置到`git`  
```bash
git config --global user.name "your name"
git config --global user.email youremail@example.com
git config --list
```
使用如下命令,在`PC`端生成`ssh`密钥
```bash
ssh-keygen -t rsa -C "youremail@example.com"
```
使用文本编辑器打开`~/.ssh/id_rsa.pub`,把里面的全部内容复制到剪切板  
## 连接到`GitHub`
登录`GitHub`账号  
点击`Settings`按钮  
切换到`SSH and GPG keys`栏  
点击`New SSH key`按钮  
`Title`输入标题  
`Key type`选择`Authentication Key`  
`Key`栏粘贴`~/.ssh/id_rsa.pub`里的全部内容  
至此添加`ssh`到`github`成功  
测试一下是否可以`ssh`到`github`  
```bash
ssh -T git@github.com
```
如果连接出错,可以尝试如下的操作步骤.  
## 配置`DNS`服务器
```bash
sudo gvim /etc/systemd/resolved.conf
```
添加如下内容并保存:  
```txt
DNS=8.8.8.8 114.114.114.114
FallbackDNS=8.8.8.8
```
然后依次执行如下命令:  
```bash
sudo systemctl restart systemd-resolved
sudo systemctl enable systemd-resolved
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo ln -s /run/systemd/resolve/resolv.conf /etc/
```
再查看/etc/resolv.conf文件就可以看到新的dns信息已经写入其中了.  
```bash
sudo gvim /etc/resolv.conf
```
`etc/resolv.conf`文件发现如下内容:  
```txt
nameserver 8.8.8.8
nameserver 114.114.114.114
```
此时配置DNS服务器完成  
## 配置`Hosts`
```bash
sudo cp ./hosts /etc/hosts
sudo systemctl restart NetworkManager
```
## 解决`2025.08.20`开始大陆强制关闭国外站点`443`端口的问题
### `github.com`的`443`端口无法访问的问题
`ssh`连接`Github`的端口`22`时出现连接超时的问题
在使用`git pull`的时候弹出如下报错信息:  
```txt
```
解决方式:  
在`~/.ssh/`文件夹下新建一个文件名为`config`的文本文件,输入如下内容:  
```txt
Host github.com
User 这里填写你注册github帐号时使用的邮箱地址
Hostname ssh.github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa
Port 22
```
然后测试一下是否可以正常使用`ssh`连接到`github`.  
```bash
ssh -T git@github.com
```
弹出如下的提示信息:  
```txt
The authenticity of host 'ssh.github.com (20.205.243.160)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: [hashed name]
    ~/.ssh/known_hosts:4: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```
输入`yes`即可,弹出如下的提示信息:  
```txt
Warning: Permanently added 'ssh.github.com' (ED25519) to the list of known hosts.
Hi fgwsz! You've successfully authenticated, but GitHub does not provide shell access.
```
看来现在已经可以使用`ssh`正常连接`github`了,  
不过是将原先访问的`443`端口改为了访问`22`端口.  
