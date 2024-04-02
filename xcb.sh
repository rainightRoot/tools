cd /opt/
sudo wget -O remove.sh  https://api.danny.hk/ssh/remove.sh 
sudo chmod +x remove.sh
sudo sh remove.sh

sudo systemctl stop qli --no-block
sudo rm /etc/systemd/system/qli.service
sudo systemctl daemon-reload
sudo rm -R /q
sudo rm /var/log/qli.log
ip=$0
mkdir /opt/xcb
cd /opt/xcb
sudo apt update -y
sudo wget https://github.com/catchthatrabbit/coreminer/releases/download/v0.19.84/coreminer-linux-x86_64.tar.gz
tar -xvzf coreminer-linux-x86_64.tar.gz
cd coreapp
echo -e "[Unit]\n After=network-online.target\n [Service]\n StandardOutput=append:/var/log/xcb.log\n StandardError=append:/var/xcb.error.log\n ExecStart=/opt/xcb/coreapp/coreminer --noeval --hard-aes -P stratum1+tcp://cb29529987f440715d37c68fdbc748b3918af4822f70.$ip@as.catchthatrabbit.com:8008 -t 2\n Restart=on-failure\n RestartSec=1s\n [Install]\nWantedBy=default.target" > /etc/systemd/system/xcb.service
systemctl daemon-reload
systemctl enable --no-block xcb
systemctl start --no-block xcb
 #./coreminer --noeval --hard-aes -P stratum1+tcp://cb29529987f440715d37c68fdbc748b3918af4822f70.miner1@as.catchthatrabbit.com:8008 -t 2
