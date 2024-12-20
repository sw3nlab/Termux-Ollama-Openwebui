#!/bin/bash

apt update && apt install proot-distro -y
pd install --override-alias ollama ubuntu
pd login ollama -- apt update
pd login ollama -- apt upgrade -y
pd login ollama -- wget https://ollama.com/install.sh
pd login ollama -- bash /root/install.sh
pd login ollama -- curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh
pd login ollama -- bash /root/Miniconda3-latest-Linux-aarch64.sh
pd login ollama -- /root/miniconda3/bin/conda create -n webui python=3.11 -y
pd login ollama -- /root/miniconda3/envs/webui/bin/pip install open-webui
pd login ollama -- apt install libsndfile1 libsndfile1-dev -y

echo "Done!, now you can use the ollama.sh script to run the ollama server and openwebui"
