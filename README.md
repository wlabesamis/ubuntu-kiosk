# Ubuntu Server 18.04 Kiosk Chrome

 

## Getting Started

These instructions will get give you an instruction on how to setup a chrome kiosk ubuntu 

### Prerequisites

Make sure you have installed the following prerequisites

Note: Installing Ubuntu Server 18.04 required an internet connection so you can install a required package

* Ubuntu Server 18.04 - [Download](https://ubuntu.com/download/server/thank-you?version=18.04.4&architecture=amd64)


### Steps

* After you successfully installed the Ubuntu Server 18.04 need to install the following package
        
    ```
    sudo apt install network-manager
    sudo nmcli dev wifi con <SSID> password <password>
    ```
* Install required packages

    ````
    sudo add-apt-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
    wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  
    sudo apt update
    sudo apt install --no-install-recommends xorg openbox google-chrome-stable pulseaudio
  
    sudo usermod -a -G audio $USER  
    ````  
* Loading Browser on Boot
    * Run the command below, it will clear a chrome session and configuration and load the 
    chrome browser
    
    ````
    sudo vi /opt/kiosk.sh
    ````
  
    * Here's the content of /opt/kiosk.sh
    ````
    #!/bin/bash
    
    xset -dpms
    xset s off
    openbox-session &
    start-pulseaudio-x11
    
    while true; do
      rm -rf ~/.{config,cache}/google-chrome/
      google-chrome --kiosk --no-first-run  'http://thepcspy.com'
    done
    ````
  
    * Run the command below to make the script executable. 
    ````
    sudo chmod +x /opt/kiosk.sh
    ````
    
    * Starting X and load the /opt/kiosk.sh, run the command below
    ````
    sudo vi /etc/init/kiosk.conf
    ````
    
    * Here's the content of /etc/init/kiosk.conf
    Note: Replace the value of "user" in "exec sudo -u user"  with the user being use
    during ubuntu server setup 
    ````
    start on (filesystem and stopped udevtrigger)
    stop on runlevel [06]
    
    console output
    emits starting-x
    
    respawn
    
    exec sudo -u user startx /etc/X11/Xsession /opt/kiosk.sh --
    ````
  
    * Install xserver-xorg-legacy and choose "Anybody"
    ````
    sudo apt install xserver-xorg-legacy
    sudo dpkg-reconfigure xserver-xorg-legacy
    ````
  
    * Modify the /etc/X11/Xwrapper.config
    ````
    sudo vi /etc/X11/Xwrapper.config
    ````
  
    * Add the following line
    ````
    needs_root_rights=yes
    ````

* Autologin user
    * Run the command below
    ````
    systemctl edit getty@tty7
    ````
  
    * See below for the content
    Note: Replace the user in "--autologin user" with the user being use
           during ubuntu server setup 
    ````
    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin user --noclear %I $TERM
    ````    
### Basic trouble shooting


## Authors

* **THEPCSPY** - (https://thepcspy.com/read/building-a-kiosk-computer-ubuntu-1404-chrome/)

## Acknowledgments

* Thank you to THEPCSPY
