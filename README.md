# Termux-ollama-openwebui
Script to install and use ollama and open webui from termux

## Installation:
  1.  Clone the repo and give execution permissions to the installer.sh script:
     ```
     chmod +x installer.sh
     ```
  2. Execute the installer:
     ```
     ./installer.sh
     ```

  The installer will use proot to install ubuntu with "ollama" alias, it will then install ollama and open webui using conda inside the proot distro.


## Usage:
Just execute the ollama.sh to start both servers.
If you want to expose your ollama server to LAN, you can add export OLLAMA_HOST=0.0.0.0 at the begining of the ollama.sh script

## How to stop ollama and webui?
pkill ollama && pkill webui

## Uninstall
pd remove ollama
