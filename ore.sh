curl https://sh.rustup.rs -sSf | sh

sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

cargo install ore-cli

tee <<EOF >/dev/null ~/ore.sh
#!/bin/bash

for((i=1;i<=100000;i++));

do
ore  --rpc https://muddy-empty-panorama.solana-mainnet.quiknode.pro/d42fd4a81ef3f53936703976642178208a1812e2/ --keypair ~/.config/solana/id.json  --priority-fee 1 mine --threads 10

done
EOF

chmod +x ~/ore.sh
sh ~/ore.sh
