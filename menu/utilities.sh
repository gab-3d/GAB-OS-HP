#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found, installing..."
    sudo apt-get install jq -y
fi

# Load descriptions and scripts from the JSON file
mapfile -t scripts < <(jq -r '.[].script' utilities.json)
mapfile -t descriptions < <(jq -r '.[].description' utilities.json)
mapfile -t descriptionReinstalls < <(jq -r '.[].descriptionReinstall' utilities.json)
mapfile -t fileChecks < <(jq -r '.[].fileCheck' utilities.json)



# Create a menu using dialog
CMD=(/usr/bin/dialog --colors  --nocancel --no-lines --clear --backtitle "Menu" --title "Main Menu" --menu "Select options:" 30 70 10)

# Generate the options for the dialog command
OPTIONS=()
for index in "${!descriptions[@]}"; do

    #check if script file exists if exists show descriptionReinstall else show description
    fileToCheck=$(eval "echo \"${fileChecks[$index]}\"")
    
    if [ -f $fileToCheck ]; then
        OPTIONS+=("${descriptionReinstalls[$index]}" "")
    else
        OPTIONS+=("${descriptions[$index]}" "")
    fi

done


# Prompt the user to make a choice from the menu
CHOICE=$("${CMD[@]}" "${OPTIONS[@]}" 2>&1 >/dev/tty)


# Check if the user selected the "Exit" button or pressed escape in case clear the screen from dialog before exiting
if [ -z "$CHOICE" ]; then
    clear
    echo "Exiting..."
    return 0
fi




#find index of the selected option
for index in "${!descriptions[@]}"; do
    if [ "${descriptions[$index]}" = "$CHOICE" ]; then
        clear
        eval "bash ${scripts[$index]}"
        exit 0
       

    fi
done

for index in "${!descriptionReinstalls[@]}"; do
    if [ "${descriptionReinstalls[$index]}" = "$CHOICE" ]; then
         clear
         eval "bash ${scripts[$index]}"
         exit 0
    fi
done

# Execute the selected script located in $HOME
#bash "$HOME/${scripts[$CHOICE]}"
 