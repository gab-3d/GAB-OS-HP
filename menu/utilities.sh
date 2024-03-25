#!/bin/bash

# Define the scripts you want to run and their descriptions
declare -A scripts
scripts=(
    ["1) Install KAMP"]="./utilities.sh"
    ["BACK"]="./menu.sh"
    ["EXIT"]="exit 0"
    # Add more scripts here...
)

# Define the order of the options
declare -a order
order=(
    "1) Run script 1"
    "BACK"
    "EXIT"
)

# Create a menu using dialog
CMD=(dialog --nocancel --nook --no-shadow --no-lines --clear --backtitle "Menu" --menu "Select options:" 30 70 10)

# Generate the options for the dialog command
OPTIONS=()
for description in "${order[@]}"; do
    OPTIONS+=("$description" "")
done

# Prompt the user to make a choice from the menu
CHOICE=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)

clear

# Otherwise, run the selected script
bash "${scripts[$CHOICE]}"