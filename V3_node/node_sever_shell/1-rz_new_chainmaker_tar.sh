
#!/bin/bash
echo "拷备新版本的安装文件压缩包到/home/fxy目录下"
cd /home/fxy
rm -f chainmaker-v*
scp root@172.21.32.13:/mnt/datadisk0/chainmaker-go/build/release/* /home/fxy/
