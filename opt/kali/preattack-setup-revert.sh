#!/usr/bin/sh

# Preattack setup, spoofing mac address + switch to monitor mode
ifconfig wlan0 down
ifconfig wlan0 hw ether 00:11:22:33:44:55
airmon-ng check kill
iwconfig wlan0 mode monitor
ifconfig wlan0 up

# Reverting back to normal managed network mode
ifconfig wlan0 down
iwconfig wlan0 mode managed
ifconfig wlan0 up
service NetworkManager restart
