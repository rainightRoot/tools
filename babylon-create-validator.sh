passwd=$0
name=$1
addr=$2

puhkey=$(babylond create-bls-key $addr)
sudo systemctl stop babylon
sudo systemctl start babylon
tee /root/.babylond/config/validator.json > /dev/null <<EOF
{ "pubkey": $puhkey, "amount": "1000000ubbn", "moniker": "$name", "website": "", "details": "$name validator", "commission-rate": "0.10", "commission-max-rate": "0.20", "commission-max-change-rate": "0.01", "min-self-delegation": "1" }
EOF

echo $passwd |babylond tx checkpointing create-validator /root/.babylond/config/validator.json --chain-id="bbn-test-3" --gas="auto" --gas-adjustment="1.5" --gas-prices="0.025ubbn" --from=wallet -y --node=https://rpc.testnet3.babylonchain.io:443
