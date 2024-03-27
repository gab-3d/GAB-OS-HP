cd $HOME
wget -O - wget -O - https://raw.githubusercontent.com/Frix-x/klippain-shaketune/main/install.sh | bash

#add [include K-ShakeTune/*.cfg] at the beginning of $HOME/printer_data/config/printer.cfg

#check if k-ShakeTune is already included in printer.cfg
if grep -q "K-ShakeTune" $HOME/printer_data/config/printer.cfg; then
    echo "K-ShakeTune is already included in printer.cfg"
    exit 0
fi

#add [include K-ShakeTune/*.cfg] at the beginning of $HOME/printer_data/config/printer.cfg
echo "[include K-ShakeTune/*.cfg]" | cat - $HOME/printer_data/config/printer.cfg > temp && mv temp $HOME/printer_data/config/printer.cfg
