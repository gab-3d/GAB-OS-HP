#!/bin/bash


# Define the scripts you want to run and their descriptions
declare -A scripts
scripts=(
    ["1) Run kiauh"]="$HOME/kiauh/kiauh.sh"
    ["2) Install components (KAMP, KLIPPAIN, GAB Utilities)"]="$HOME/GAB-OS-HP/menu/utilities.sh"
    ["3) CanBus"]="$HOME/GAB-OS-HP/menu/canbusmnu.sh"
    ["4) Flash MK3"]="$HOME/GAB-OS-HP/menu/mk3Flash.sh"
    # Add more scripts here...
)

# Define the order of the options
declare -a order
order=(
    "1) Run kiauh"
    "2) Install components (KAMP, KLIPPAIN, GAB Utilities)"
    "3) CanBus"
    "4) Flash MK3"
)

# Create a menu using dialog
CMD=(/usr/bin/dialog --colors --no-ok --nocancel --no-lines --clear --backtitle "Menu" --title "Main Menu" --extra-button --extra-label "Exit" --menu "Select options:" 30 70 10)


# Generate the options for the dialog command
OPTIONS=()
for description in "${order[@]}"; do
    OPTIONS+=("$description" "")
done

# Prompt the user to make a choice from the menu
CHOICE=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)

clear
#check if a choice was made
if [ -z "$CHOICE" ]; then
    exit
fi
# Otherwise, run the selected script
bash "${scripts[$CHOICE]}"
