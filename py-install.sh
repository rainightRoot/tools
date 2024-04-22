mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
 /root/.zshrc

 rm -rf Llama-Chinese
 git clone https://github.com/LlamaFamily/Llama-Chinese.git

 conda create -n llama python=3.10.13

 conda activate llama

 cd Llama-Chinese

 pip install -r requirements.txt -y

 pip install flash_attn

 pip install -U huggingface_hub

mkdir ~/model_data

cd ~/model_data

huggingface-cli download --resume-download FlagAlpha/Atom-7B --local-dir FlagAlpha/Atom-7B
