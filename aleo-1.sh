cd ~/aleominer;
wget -O aleo_prover  http://192.168.0.188/aleo_prover
chmod +x aleo_prover

sudo tee <<EOF >/dev/null /etc/systemd/system/aleo.service
[Unit]
Description=runners
After=network-online.target
[Service]
User=samwang
ExecStart=~/aleominer/aleo_prover --pool p2.hcpool.click:20003 --address  aleo16s7e2z9qwk5kxckd8gzzlxcfq7mc0j0a05l02g92trgzk4fzsgfqv9zrgh --custom_name  $(hostname)
Restart=on-failure
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable aleo
sudo systemctl daemon-reload
sudo systemctl restart aleo
