#Install google chrome xorg and openbox
sudo apt update -y
sudo apt install -y --no-install-recommends xorg openbox google-chrome-stable pulseaudio xserver-xorg-legacy
sudo usermod -a -G audio $USER

#Install xserver-xorg-legacy and choose "Anybody"
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
echo "needs_root_rights=yes" | sudo tee -a /etc/X11/Xwrapper.config

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

#install kiosh service
sudo cp kiosk.sh /opt/
sudo chmod +x /opt/kiosk.sh
sudo cp kiosk.service /etc/systemd/system/
sudo systemctl enable kiosk.service
sudo systemctl start kiosk.service
