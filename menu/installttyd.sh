sudo apt --yes install build-essential cmake git libjson-c-dev libwebsockets-dev git tmux jq
cd $HOME
git clone https://github.com/tsl0922/ttyd
cd ttyd/
mkdir build
cd build
cmake ..
make && sudo make install
sudo cp ttyd /opt/

#wtrite the ttyd service file
SERVICEFILE='
[Unit]
Description=TTYD
After=syslog.target
After=network.target

[Service]
ExecStart=/opt/ttyd -t fontSize=24 -W -p 8080 login
Type=simple
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target'

sudo echo "$SERVICEFILE" | sudo tee /etc/systemd/system/ttyd.service

sudo systemctl daemon-reload
sudo systemctl enable ttyd
sudo systemctl start ttyd
echo "ttyd installed and started"