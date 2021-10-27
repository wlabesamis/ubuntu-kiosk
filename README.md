# Ubuntu Server 18.04 Kiosk Chrome

 

## Getting Started

This document will give you an instruction on how to setup a chrome kiosk ubuntu

### Prerequisites

Make sure you have installed the following prerequisites

Note: Installing Ubuntu Server 18.04 required an internet connection 
for you to able to install a required package, create a "kiosk" user, this user will
be use in the setup later

* Ubuntu Server 18.04 - [Download](https://ubuntu.com/download/server/thank-you?version=18.04.4&architecture=amd64)
* Setup for Ubuntu Server - [Video](https://www.youtube.com/watch?v=XXsrECecr5M)


### Steps

* After you successfully installed the Ubuntu Server 18.04 need to install the following package, the 4th line
is a wifi setup wherein the SSID is the name of your WIFI and password is the password of your wifi, you can skip
the command below if you are using LAN.
        
    ```
    sudo apt install network-manager
    sudo systemctl enable NetworkManager
    sudo service NetworkManager start
    sudo nmcli dev wifi con <SSID> password <password>
    ```
* Install required packages

    ````
    sudo add-apt-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
    wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  
    sudo apt update
    sudo apt install --no-install-recommends xorg openbox google-chrome-stable pulseaudio xserver-xorg-legacy
  
    sudo usermod -a -G audio $USER
    ````  
  
* Installing kiosk script, this script will open a chrome browser
    * Run the command below, it will clear a chrome session and configuration and load the 
    chrome browser
    
    ````
    sudo cp kiosk.sh /opt/
    sudo chmod +x /opt/kiosk.sh
    ````
    
    * Modify the /etc/X11/Xwrapper.config
    ````
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
    echo "needs_root_rights=yes" | sudo tee -a /etc/X11/Xwrapper.config


* Update Grub
    * Modify the /etc/default/grub
    ````
    sudo cp grub /etc/default/grub
    sudo update-grub
    ````
  
    * Enable tty2 and tty3
    ````
    sudo systemctl enable getty@tty2 getty@tty3
    ````
  
* Start kiosk service, run the command below
    ````
    sudo cp kiosk.service /etc/systemd/system/
    sudo systemctl enable kiosk.service
    sudo systemctl start kiosk.service
    ````

### Video Tutorial
https://youtu.be/cLiX62QhB9U


## Authors

* **WLABESAMIS** - (https://github.com/wlabesamis)


## Acknowledgments

* Thank you to THEPCSPY
* **THEPCSPY** - (https://thepcspy.com/read/building-a-kiosk-computer-ubuntu-1404-chrome/)
