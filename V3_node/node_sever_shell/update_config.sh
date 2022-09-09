#!/bin/bash
org="org1"
path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org/"
cd ${path}

sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11301\/p2p\/Qm/\"\/ip4\/172.21.32.11\/tcp\/11301\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11302\/p2p\/Qm/\"\/ip4\/172.21.32.5\/tcp\/11302\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11303\/p2p\/Qm/\"\/ip4\/172.21.32.7\/tcp\/11303\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11304\/p2p\/Qm/\"\/ip4\/172.21.32.6\/tcp\/11304\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11305\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11305\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11306\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11306\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11307\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11307\/p2p\/Qm/g' chainmaker.yml
