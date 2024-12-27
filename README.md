# Termux-doomsday-LLM
Script to install and use ollama, open webui, big-AGI, fastsdcpu, llamacpp, Automatic 1111, exo and text-generation-webui oobabooga from termux

*Added support for fastsdcpu, the first time generating an image will take long because it needs to download the models, check the original repo to use different models https://github.com/rupeshs/fastsdcpu?tab=readme-ov-file#gguf-support

Automatic 1111 will also start the API by default so you are able to use it with SDAI app and the webui.

## Installation:
  1.  Clone the repo and give execution permissions to the installer.sh script:
     ```
     chmod +x installer.sh
     ```
  2. Execute the installer:
     ```
     ./installer.sh
     ```

  The installer will use two different proot distros, one for ollama named "ollama" and another one for the UI's called "ui", it will use conda for the installation of open webui, oobabooga and fastsdcpu.
  Llamacpp will be installed on termux HOME folder, do not move the folder.
  The user can choose what they want to install from a simple menu

## Usage:
<pre>
Just execute the run.sh to start and stop the servers.

Exposing servers, edit the run.sh script:
Ollama:
  Find this part:
                        pd login ollama -- bash -c "ollama serve" &

  And change it for this:

                        pd login ollama -- bash -c "export OLLAMA_HOST=0.0.0.0 && ollama serve" &

Fastsdcpu:
  change pd login ui -- bash -c "cd fastsdcpu && bash start-webui.sh" &
  to
  pd login ui -- bash -c "export GRADIO_SERVER_NAME=0.0.0.0 && cd fastsdcpu && bash start-webui.sh" &
                       

Big-AGI 
  change -H 127.0.0.1 to -H 0.0.0.0

Text-generation-webui oobabooga
  add --listen after "--listen-port 7861"

Automatic 1111:
  This is a little more tricky.
  pd login --user auto ui
  nano stable-diffusion-webui/webui-user.sh
  look for the line that says export COMMANDLINE_ARGS="--port 7865 --api --use-cpu all --precision full --no-half --skip-torch-cuda-test"
  add --listen behind --port 7865
  ctrl X to save
  
big-AGI: localhost:8081
open-webui: localhost:8082
oobabooga: localhost:7861
ollama: localhost:11434
fastsdcpu: localhost:7860
Automatic 1111: localhost:7865
</pre>
## Uninstall
pd remove ollama && pd remove ui && pd remove exo && rm -rf ~/llama.cpp

## Add models to Automatic 1111:
<pre>
  pd login --user auto ui
  cd stable-diffusion-webui/models
  Download your models using wget and put them in the required folder
</pre>
## Supported tools so far:
<pre>
  ollama
  open webui
  fastsdcpu
  big-AGI
  text-generation-webui oobabooga
  llamacpp
  Automatic 1111
  exo
</pre>
