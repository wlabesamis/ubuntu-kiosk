#Install network manager
sudo apt install network-manager -y
sudo systemctl enable NetworkManager
sudo service NetworkManager start

#Connect to WIFI
echo "please enter SSID to connect to wifi"
read SSID
echo "please enter $SSID password"
read PASSWORD
sudo nmcli dev wifi con $SSID password $PASSWORD



