
filename="address"
apt install sshpass -y

while IFS= read -r line
do
    echo "$line"
    # ssh -n -o "StrictHostKeyChecking no" ubuntu@$line "sudo su - root -c 'journalctl -u ceremonyclient.service  -n 10;exit'"> ./run_log/$line".log"
    mkdir -p ./backup/$line
   sshpass -p 'tType=vm1' scp -r root@$line:/root/ceremonyclient/node/.config  ./backup/$line/config
    #ssh -n -o "StrictHostKeyChecking no" ubuntu@$line "sudo su - root -c 'cd /root/ceremonyclient/node/.config && cat keys.yml;exit'"> ./backup/$line/keys.yml
    ssh -n -o "StrictHostKeyChecking no" root@$line "sudo su - root -c 'cd ~/ceremonyclient/node && ./node-1.4.21-linux-amd64 --peer-id;exit'"> ./backup/$line/peerid.txt

    # ssh ubuntu@$line "pwd"

done < "$filename"

