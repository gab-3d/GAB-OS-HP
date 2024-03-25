#!/bin/bash

# Define the scripts you want to run and their descriptions
declare -A scripts
scripts=(
    ["1) Install components (KAMP, KLIPPAIN, GAB Utilities)"]="./utilities.sh"
    ["2) CanBus"]="./canbusmnu.sh"
    ["EXIT"]="exit 0"
    # Add more scripts here...
)

# Define the order of the options
declare -a order
order=(
    "1) Install components (KAMP, KLIPPAIN, GAB Utilities)"
    "2) CanBus"
    "EXIT"
)

# Create a menu using dialog
CMD=(dialog --colors --nocancel --nook --no-shadow --no-lines --clear --backtitle "Menu" --title "Main Menu" --menu "Select options:" 30 70 10)

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