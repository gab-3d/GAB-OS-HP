#!/bin/bash

# Define the scripts you want to run and their descriptions
declare -A scripts
scripts=(
    ["1) Install KAMP"]="~/kiauh/kiauh.sh"
    ["2) Install KLIPPAIN"]="./utilities.sh"
    ["3) Install GAB Utilities"]="./canbusmnu.sh"
    ["4) Main Menu"]="./menu.sh"

    # Add more scripts here...
)

# Define the order of the options
declare -a order
order=(
    "1) Install KAMP"
    "2) Install KLIPPAIN"
    "3) Install GAB Utilities"
    "4) Main Menu"
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