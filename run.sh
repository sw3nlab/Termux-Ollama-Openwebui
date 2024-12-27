#!/data/data/com.termux/files/usr/bin/bash

# Function to display the main menu and get the user's action
display_main_menu() {
    echo "What would you like to do?"
    echo "1. Run utilities"
    echo "2. Stop utilities"
    echo "3. Exit"
}

# Function to display the menu for selecting utilities to run
display_run_menu() {
    echo "Select utilities to run (separate choices with spaces):"
    echo "1. Ollama"
    echo "2. Open WebUI"
    echo "3. Oobabooga"
    echo "4. Big-AGI"
    echo "5. fastsdcpu"
    echo "6. download llamacpp models"
    echo "7. llamacpp (fastest)"
    echo "8. Automatic 1111"
    echo "9. exo"
    echo "10. Back to main menu"
}

# Function to display the menu for selecting utilities to stop
display_stop_menu() {
    echo "Select utilities to stop (separate choices with spaces):"
    echo "1. Ollama"
    echo "2. Open WebUI"
    echo "3. Oobabooga"
    echo "4. Big-AGI"
    echo "5. fastsdcpu"
    echo "6. Automatic 1111"
    echo "7. exo"
    echo "8. Back to main menu"
}

display_download_menu() {
    echo "Select utilities to stop (separate choices with spaces):"
    echo "1. llama3.2 (3b)"
    echo "2. qwen2.5 (7b)"
    echo "3. llama3.1 (7b)"
    echo "4. other"
}

display_llamacpp_models() {
	dir=~/llama.cpp/models2
	models=("$dir"/*)
	if [ ${#models[@]} -eq 0 ]; then
  	  echo "No models found in $dir."
  	  exit 1
	fi
	echo "Available models:"
	for i in "${!models[@]}"; do
	    echo "$((i + 1)). ${models[$i]##*/}"
	done
	while true; do
	    read -p "Enter the number of the model to use: " choice

	    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#models[@]} ]; then
	        selected_file="${models[$((choice - 1))]}"
	        break
	    else
	        echo "Invalid choice. Please enter a number between 1 and ${#models[@]}."
	    fi
	done

	echo "You selected: ${selected_file##*/}"
	model_name="${selected_file##*/}"
}

# Main script logic
while true; do
    clear
    display_main_menu
    read -p "Enter your choice: " action

    case $action in
        1)
            # Run utilities
            clear
            display_run_menu
            read -p "Enter your choices: " choices

            # Process each choice to run
            for choice in $choices; do
                case $choice in
                    1)
                        echo "Starting Ollama..."
                        pd login ollama -- bash -c "ollama serve" &
                        ;;
                    2)
                        echo "Starting Open WebUI..."
                        pd login ui -- /root/miniconda3/envs/webui/bin/python3 /root/miniconda3/envs/webui/bin/open-webui serve --port 8082 &
                        ;;
                    3)
                        echo "Starting Oobabooga..."
                        pd login ui -- bash -c "cd text-generation-webui && /root/miniconda3/envs/textgen/bin/python3 server.py --cpu --listen-port 7861" &
                        ;;
                    4)
                        echo "Starting Big-AGI..."
                        pd login ui -- bash -c "cd big-AGI && npx next start --port 8081 -H 127.0.0.1" &
                        ;;
		    5)
			echo "Starting fastsdcpu"
			pd login ui -- bash -c "cd fastsdcpu && bash start-webui.sh" &
                        ;;
                    6)
			clear
			display_download_menu
                        read -p "Enter your choice: " action
			    case $action in
				1)
                                    cd ~/llama.cpp/models2 && wget https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_0.gguf
	                            ;;
                                2)
                                    cd ~/llama.cpp/models2 && wget https://huggingface.co/mradermacher/Qwen2.5-7B-Instruct-Uncensored-GGUF/resolve/main/Qwen2.5-7B-Instruct-Uncensored.Q4_K_M.gguf
                                    ;;
                                3)
                                    cd ~/llama.cpp/models2 && wget https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF/resolve/main/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf
                                    ;;
                                4)
				    read -p "Paste huggingface link: " link
                                    cd ~/llama.cpp/models2 && wget $link
                                    ;;
			    esac
                        ;;
                    7)
                        clear
                        display_llamacpp_models
                        read -p "context size (default = 4096, 0 = loaded from model): " context
			read -p "How many threads? (-1 to use all): " threads
			read -p "System prompt: " prompt
			read -p "Custom arguments: " arguments
			eval set -- $arguments
			~/llama.cpp/build/bin/llama-cli -m ~/llama.cpp/models2/$model_name -c $context -t $threads -p $prompt -cnv "$@"
			echo "Menu will be back in 5 seconds"
			sleep 5s
                        ;;
                    8)
                        pd login --user auto ui -- bash -c "cd stable-diffusion-webui && ./webui.sh" &
                        ;;
		    9)
                        pd login exo -- bash -c "cd exo && CLANG=1 pipenv run exo" &
                        ;;
                    10)
                        break
                        ;;
                    *)
                        echo "Invalid choice: $choice"
                        ;;
                esac
            done
            echo "All selected utilities are running."
            ;;
        2)
            # Stop utilities
            clear
            display_stop_menu
            read -p "Enter your choices: " choices

            # Process each choice to stop
            for choice in $choices; do
                case $choice in
                    1)
                        echo "Stopping Ollama..."
                        pkill ollama
                        ;;
                    2)
                        echo "Stopping Open WebUI..."
                        pkill webui
                        ;;
                    3)
                        echo "Stopping Oobabooga..."
                        pkill -f "python3 server.py"
                        ;;
                    4)
                        echo "Stopping Big-AGI..."
                        pkill -f "next start"
                        pkill -f "next-server"

                        # Check manually if needed
                        if ! pkill -f "next start" && ! pkill -f "next-server"; then
                            echo "Big-AGI not stopped with pkill. Checking process manually..."
                            pid=$(ps aux | grep "next start" | grep -v "grep" | awk '{print $2}')
                            if [ -n "$pid" ]; then
                                echo "Found Big-AGI process with PID: $pid. Stopping it..."
                                kill -9 $pid
                            else
                                echo "Big-AGI process not found."
                            fi
                        fi
                        ;;
		    5)
			echo "Stopping fastsdcpu"
			pkill "/root/miniconda3/envs/fastsdcpu/bin/python3"
                        ;;
                    6)
                        pkill venv/bin/python
                        ;;
                    7)
                        pkill exo
                        ;;
                    8)
                        break
                        ;;
                    *)
                        echo "Invalid choice: $choice"
                        ;;
                esac
            done
            echo "All selected utilities are stopped."
            ;;
        3)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice: $action"
            ;;
    esac
done
