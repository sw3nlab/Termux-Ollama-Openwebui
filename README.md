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
If you don't want to expose your ollama server to LAN, you can remove the OLLAMA_HOST:0.0.0.0 line at the begining of the ollama.sh script (recommended if you're only gonna use it on your device)

## How to stop ollama and webui?
pkill ollama && pkill webui
