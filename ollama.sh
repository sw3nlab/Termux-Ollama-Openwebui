#!/data/data/com.termux/files/usr/bin/bash

pd login ollama -- ollama serve &
pd login ollama -- /root/miniconda3/envs/webui/bin/python3 /root/miniconda3/envs/webui/bin/open-webui serve &
