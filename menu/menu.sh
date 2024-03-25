#!/bin/bash

# Define the scripts you want to run and their descriptions
declare -A scripts
scripts=(
    ["/path/to/script1.sh"]="Run script 1"
    ["/path/to/script2.sh"]="Run script 2"
    # Add more scripts here...
)

# Create a menu using dialog
CMD=(dialog --clear --backtitle "Menu" --menu "Select options:" 15 40 4)

# Generate the options for the dialog command
OPTIONS=()
for script in "${!scripts[@]}"; do
    OPTIONS+=("$script" "${scripts[$script]}")
done

# Add an "Exit" option
OPTIONS+=("EXIT" "Exit the script")

# Prompt the user to make a choice from the menu
CHOICE=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)

clear
# If the user chose "EXIT", exit the script
if [[ $CHOICE == "EXIT" ]]; then
    exit 0
fi

# Otherwise, run the selected script
bash "$CHOICE"