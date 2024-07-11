sudo sed -i 's|listenGrpcMultiaddr: ""|listenGrpcMultiaddr: "/ip4/127.0.0.1/tcp/8337"|' ./ceremonyclient/node/.config/config.yml
sudo sed -i 's|listenRESTMultiaddr: ""|listenRESTMultiaddr: "/ip4/127.0.0.1/tcp/8338"|' ./ceremonyclient/node/.config/config.yml
sudo sed -i 's|statsMultiaddr: ""|statsMultiaddr: "/dns/stats.quilibrium.com/tcp/443"|' ./ceremonyclient/node/.config/config.yml
