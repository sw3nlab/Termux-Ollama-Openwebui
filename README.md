# Termux-ollama-openwebui-big-AGI-oobabooga
Script to install and use ollama, open webui, big-AGI, fastsdcpu and oobabooga from termux
*Added support for fastsdcpu, the first time generating an image will take some time because it needs to download the models, check the original repo to use different models https://github.com/rupeshs/fastsdcpu?tab=readme-ov-file#gguf-support

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
  The user can choose what they want to install from a simple menu

## Usage:
<pre>
Just execute the run.sh to start and stop the servers.
If you want to expose your ollama server to LAN, you can add export OLLAMA_HOST=0.0.0.0 in the run.sh script.
Find this part:
                        pd login ollama -- bash -c "ollama serve" &

And change it for this:

                        pd login ollama -- bash -c "export OLLAMA_HOST=0.0.0.0 && ollama serve" &

For fastsdcpu:
  change pd login ui -- bash -c "cd fastsdcpu && bash start-webui.sh" &
  to
  pd login ui -- bash -c "export GRADIO_SERVER_NAME=0.0.0.0 && cd fastsdcpu && bash start-webui.sh" &
                       

For big-AGI to be accessible on LAN change -H 127.0.0.1 to -H 0.0.0.0
For oobabooga to be accessible on LAN, add --listen after "--listen-port 7861"
  
big-AGI: localhost:8081
open-webui: localhost:8082
oobabooga: localhost:7861
ollama: localhost:11434
fastsdcpu: localhost:7860
</pre>
## Uninstall
pd remove ollama && pd remove ui
