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

 pip install -r requirements.txt

 pip install flash_attn

 pip install -U huggingface_hub

mkdir ~/model_data

cd ~/model_data

huggingface-cli download --resume-download FlagAlpha/Atom-7B --local-dir FlagAlpha/Atom-7B

sudo tee ~/Llama-Chinese/demo.py > /dev/null << EOF
import torch

from transformers import AutoTokenizer, AutoModelForCausalLM

# import os

# os.environ["TRANSFORMERS_OFFLINE"] = "1"

device_map = "cuda:0" if torch.cuda.is_available() else "auto"

model = AutoModelForCausalLM.from_pretrained('/root/model_data/FlagAlpha/Atom-7B',device_map=device_map,torch_dtype=torch.float16,load_in_8bit=True,trust_remote_code=True,use_flash_attention_2=True)

model =model.eval()

tokenizer = AutoTokenizer.from_pretrained('/root/model_data/FlagAlpha/Atom-7B',use_fast=False)

tokenizer.pad_token = tokenizer.eos_token

input_ids = tokenizer(['<s>Human: 介绍一下中国\n</s><s>Assistant: '], return_tensors="pt",add_special_tokens=False).input_ids

if torch.cuda.is_available():

  input_ids = input_ids.to('cuda')

generate_input = {

    "input_ids":input_ids,

    "max_new_tokens":512,

    "do_sample":True,

    "top_k":50,

    "top_p":0.95,

    "temperature":0.3,

    "repetition_penalty":1.3,

    "eos_token_id":tokenizer.eos_token_id,

    "bos_token_id":tokenizer.bos_token_id,

    "pad_token_id":tokenizer.pad_token_id

}

generate_ids  = model.generate(**generate_input)

text = tokenizer.decode(generate_ids[0])

print(text)
EOF
