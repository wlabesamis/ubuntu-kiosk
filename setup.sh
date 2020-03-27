#Install network manager
sudo apt install network-manager -y
sudo systemctl enable NetworkManager
sudo service NetworkManager start

#Connect to WIFI
echo "please enter SSID to connect to wifi"
read SSID
echo "please enter SSID password"
read PASSWORD
sudo nmcli dev wifi con $SSID password $PASSWORD

#Install google chrome xorg and openbox
sudo add-apt-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo apt update -y
sudo apt install -y --no-install-recommends xorg openbox google-chrome-stable pulseaudio
sudo usermod -a -G audio $USER

#Add new user
sudo adduser user
sudo usermod -aG sudo user

#Install xserver-xorg-legacy and choose "Anybody"
sudo apt install xserver-xorg-legacy
sudo dpkg-reconfigure xserver-xorg-legacy
sudo echo "needs_root_rights=yes" >> /etc/X11/Xwrapper.config

#Do not load the desktop
sudo systemctl enable multi-user.target --force
sudo systemctl set-default multi-user.target

#Enable tty1 tty2 tty3
sudo systemctl enable getty@tty1
sudo systemctl enable getty@tty2
sudo systemctl enable getty@tty3

#Enable auto login in tty1
sudo install -b -m 644 /dev/stdin /etc/systemd/system/getty\@tty1.service.d/override.conf << EOF
[Service]
ExecStart=
ExexStart=-/sbin/agetty --autologin kiosk --noclear %I $TERM
Type=idle
EOF

#install kiosh script
sudo cp kiosk.sh /opt/
sudo chmod +x /opt/kiosk.sh
sudo cp .bash_profile ~/.bash_profile