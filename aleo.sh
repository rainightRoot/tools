cd 
sudo wget -O remove.sh  https://api.danny.hk/ssh/remove.sh 
sudo chmod +x remove.sh
sudo sh remove.sh
sudo rm -rf aleo-pool-prover
sudo wget -O aleo-pool-prover http://192.168.6.115/aleo-pool-prover
sudo chmod +x aleo-pool-prover
ip= ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}' 
array=(`echo $ip | tr '\n' ' '` ) 
ip_=${array[0]/./_}
sudo tee <<EOF >/dev/null /etc/systemd/system/aleo.service
[Unit]
Description=runners
After=network-online.target
[Service]
User=root
ExecStart=~/aleo-pool-prover --account equinox --pool wss://aleo.zklion.com:3777 --worker-name work-yidong-$ip_
Restart=on-failure
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable aleo
sudo systemctl daemon-reload
sudo systemctl restart aleo
