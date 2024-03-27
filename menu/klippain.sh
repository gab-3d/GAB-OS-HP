cd $HOME
wget -O - wget -O - https://raw.githubusercontent.com/Frix-x/klippain-shaketune/main/install.sh | bash

#add [include K-ShakeTune/*.cfg] on to of $HOME/printer_data/config/printer.cfg
echo "[include K-ShakeTune/*.cfg]" >> $HOME/printer_data/config/printer.cfg
 