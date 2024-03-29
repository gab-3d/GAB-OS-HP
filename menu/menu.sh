#!/bin/bash
cd ~/GAB-OS-HP/menu
# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found, installing..."
    sudo apt-get install jq -y
fi






# Load descriptions and scripts from the JSON file
mapfile -t scripts < <(jq -r '.[].script' menu.json)
mapfile -t descriptions < <(jq -r '.[].description' menu.json)



# Create a menu using dialog add an exit button

CMD=(/usr/bin/dialog --colors  --nocancel --no-lines --clear --backtitle "Menu" --title "Main Menu" --extra-button --extra-label "Exit" --menu "Select options:" 30 70 10)

# Generate the options for the dialog command
OPTIONS=()
for index in "${!descriptions[@]}"; do
    OPTIONS+=("${descriptions[$index]}" "")
    //echo "${scripts[$index]}" 
done

# Prompt the user to make a choice from the menu
CHOICE=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)

# Check if the user selected the "Exit" button
if [ $? -eq 3 ]; then
    echo "Exiting..."
    exit 0
fi

#find index of the selected option
for index in "${!descriptions[@]}"; do
    if [ "${descriptions[$index]}" = "$CHOICE" ]; then
        CHOICE=$index
        break
    fi
done

#check is choice is eqal to the last element or is empty and exit
if [ $CHOICE -eq $((${#descriptions[@]}-1)) ]; then
    clear
    echo "Exiting..."
    exit 0
fi


#check is choice is empty and exit
if [ -z "$CHOICE" ]; then
    clear
    echo "Exiting..."
    
    exit 0
fi
clear

# Execute the selected script located in $HOME
bash "$HOME/${scripts[$CHOICE]}" 
 