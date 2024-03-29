#!/bin/bash

#get the type and speed as input parameters

type=$1
speed=$2

#check if the type is can or bridge
if [ "$type" != "can" ] && [ "$type" != "bridge" ]; then
    echo "Type is not can or bridge"
    exit 1
fi

#check if the speed is 1000000 or 500000
if [ "$speed" != "1000000" ] && [ "$speed" != "500000" ]; then
    echo "Speed is not 1000000 or 500000"
    exit 1
fi

#chek if /etc/network/interfaces.d/can0 exists
if [ -f /etc/network/interfaces.d/can0 ]; then
    sudo rm /etc/network/interfaces.d/can0
fi

#switch type
case $type in
    can)
        #switch speed
        case $speed in
            1000000)
                CANdoc='
allow-hotplug can0
iface can0 can static
    bitrate 1000000
    up ifconfig $IFACE txqueuelen 128
'
        ;;
            500000)
            CANdoc='
allow-hotplug can0
iface can0 can static
    bitrate 500000
    up ifconfig $IFACE txqueuelen 128
';;
        esac

;;
    bridge)
        #switch speed
        case $speed in
            1000000)
                CANdoc='
allow-hotplug can0
iface can0 can static
    bitrate 1000000
    up ifconfig $IFACE txqueuelen 128

'
;;
            500000)
            CANdoc='
allow-hotplug can0
iface can0 can static
    bitrate 500000
    up ifconfig $IFACE txqueuelen 128
'       
;; 
        esac

esac
# Ensure CANdoc is defined and not empty
if [ -z "$CANdoc" ]; then
    echo "Error: CANdoc is not set or is empty"
    exit 1
fi
# Check if the directory exists
if [ ! -d "/etc/network/interfaces.d/" ]; then
    # If not, create the directory
    sudo mkdir -p /etc/network/interfaces.d/
fi
#create the can0 file and append CANdoc to it

echo "$CANdoc" | sudo tee /etc/network/interfaces.d/can0


#reloadl can configuration and restart the can0 interface

# sudo if down can0
# sudo if up can0