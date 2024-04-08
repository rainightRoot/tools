# echo 1 |curl https://sh.rustup.rs -sSf | sh
# source "$HOME/.cargo/env"
apt install cargo -y
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

cargo install ore-cli

tee <<EOF >/dev/null ~/ore.sh
#!/bin/bash

for((i=1;i<=100000;i++));

do

/root/.cargo/bin/ore --rpc https://muddy-empty-panorama.solana-mainnet.quiknode.pro/d42fd4a81ef3f53936703976642178208a1812e2/ --keypair ~/.config/solana/id.json --priority-fee 1 mine --threads 10

done
EOF

chmod +x ~/ore.sh

screen -S ore

./ore.sh &

# tee <<EOF >/dev/null /etc/systemd/system/ore.service
# [Unit]
# After=network.target
# [Service]
# StandardOutput=append:/var/log/ore.log
# StandardError=append:/var/ore.error.log
# ExecStart=ore  --rpc https://muddy-empty-panorama.solana-mainnet.quiknode.pro/d42fd4a81ef3f53936703976642178208a1812e2/ --keypair ~/.config/solana/id.json  --priority-fee 1 mine --threads 10
# Restart=on-failure
# RestartSec=1s
# [Install]
# WantedBy=default.target
# EOF

# systemctl daemon-reload
# systemctl enable --no-block ore.service
# systemctl restart --no-block ore.service

