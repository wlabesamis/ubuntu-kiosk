# Ubuntu Server 18.04 Kiosk Chrome

 

## Getting Started

These instructions will give you an instruction on how to setup a chrome kiosk ubuntu 

### Prerequisites

Make sure you have installed the following prerequisites

Note: Installing Ubuntu Server 18.04 required an internet connection 
for you to able to install a required package

* Ubuntu Server 18.04 - [Download](https://ubuntu.com/download/server/thank-you?version=18.04.4&architecture=amd64)
* Install Ubuntu Server 18.04 [HOW TO](https://ubuntu.com/tutorials/tutorial-install-ubuntu-server#1-overview)


### Steps

* After you successfully installed the Ubuntu Server 18.04 need to install the following package
        
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
    sudo apt install --no-install-recommends xorg openbox google-chrome-stable pulseaudio
  
    sudo usermod -a -G audio $USER
    ````  
* Add new user
    ````
    sudo adduser user
    sudo usermod -aG sudo user
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
    systemctl enable getty@tty1
    systemctl edit getty@tty1
    ````
  
    * See below for the content
    Note: Replace the user in "--autologin user" with the user being use
           during ubuntu server setup 
    ````
    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin user --noclear %I $TERM
    ````    

* Update Grub
    * Modify the /etc/default/grub
    ````
    sudo vi /etc/default/grub
    ````
  
    * Update the file based on the content below
    ````
    GRUB_DEFAULT=0
    GRUB_HIDDEN_TIMEOUT=0
    GRUB_HIDDEN_TIMEOUT_QUIET=true
    GRUB_TIMEOUT=0
    GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
    GRUB_CMDLINE_LINUX_DEFAULT="text"
    GRUB_CMDLINE_LINUX=""
    GRUB_TERMINAL=console
    ````
  
    * Save the changes
    ````
    sudo update-grub
    ````
  
    * Do not load the desktop
    ````
    sudo systemctl enable multi-user.target --force
    sudo systemctl set-default multi-user.target
    ````
  
    * Enable tty2
    ````
    sudo systemctl enable getty@tty2
    ````
  
* Starting X and load the /opt/kiosk.sh, run the command below
    ````
    sudo vi ~/.bash_profile
    ````
    
    * Here's the content of ~/.bash_profile
    ````
    startx /etc/X11/Xsession /opt/kiosk.sh --
    ````

### Basic trouble shooting


## Authors

* **THEPCSPY** - (https://thepcspy.com/read/building-a-kiosk-computer-ubuntu-1404-chrome/)

## Acknowledgments

* Thank you to THEPCSPY
