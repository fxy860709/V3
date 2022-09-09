
#!/bin/bash
echo "拷备新版本的安装文件压缩包到/home/fxy目录下"
cd /home/fxy
rm -f chainmaker-v*
scp root@172.21.48.17:/home/projects/test/chainmaker-go/build/release/* /home/fxy/
