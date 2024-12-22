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
Just execute the run.sh to start and stop the servers.
If you want to expose your ollama server to LAN, you can add export OLLAMA_HOST=0.0.0.0 in the run.sh script.
Find this part:
1)
                        echo "Starting Ollama..."
                        pd login ollama -- ollama serve &
                        ;;

And change it for this:
1)
                        echo "Starting Ollama..."
                        export OLLAMA_HOST=0.0.0.0
                        pd login ollama -- ollama serve &
                        ;;

big-AGI: localhost:8081
open-webui: localhost:8082
oobabooga: localhost:7861
ollama: localhost:11434
fastsdcpu: localhost:7860

## Uninstall
pd remove ollama && pd remove ui
