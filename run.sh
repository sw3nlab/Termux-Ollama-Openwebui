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
    echo "6. Back to main menu"
}

# Function to display the menu for selecting utilities to stop
display_stop_menu() {
    echo "Select utilities to stop (separate choices with spaces):"
    echo "1. Ollama"
    echo "2. Open WebUI"
    echo "3. Oobabooga"
    echo "4. Big-AGI"
    echo "5. fastsdcpu"
    echo "6. Back to main menu"
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
                        pd login ollama -- ollama serve &
                        ;;
                    2)
                        echo "Starting Open WebUI..."
                        pd login ui -- /root/miniconda3/envs/webui/bin/python3 /root/miniconda3/envs/webui/bin/open-webui serve --port 8082 &
                        ;;
                    3)
                        echo "Starting Oobabooga..."
                        pd login ui -- bash -c "cd text-generation-webui && /root/miniconda3/envs/textgen/bin/python3 server.py --listen --cpu --listen-port 7861" &
                        ;;
                    4)
                        echo "Starting Big-AGI..."
                        pd login ui -- bash -c "cd big-AGI && npx next start --port 8081 -H 0.0.0.0" &
                        ;;
		    5)
			echo "Starting fastsdcpu"
			pd login ui -- bash -c "cd fastsdcpu && bash start-webui.sh" &
                        ;;
                    6)
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
