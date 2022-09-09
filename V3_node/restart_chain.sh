#/bin/bash
ips=(172.21.48.7 172.21.48.3 172.21.48.12 172.21.48.4)
for i in [1..4];do
        num=` expr i - 1 `
        echo ${ips[$num]}
        echo "/root/chainmaker-v2.3.0_alpha-wx-org${i}.chainmaker.org"
        ssh -p 36000 root@${ips[$num]}
        mkdir /root/xiefeng
done
