# Welcome to OpenSourceThinClient

OpenSourceThinClient is a boot image which allows low-end PCs to be used as a thin-client to login to remote computers. The project is a modified version of Xubuntu Core that starts up into a simple menu for RDP and SSH services. The OS is as lightweight as possible so that it can be run using a USB with persistent storage. 

## Download the ISO and create Bootable USB using Rufus
* [Rufus](https://rufus.ie/en/)
* [OSTC ISO File](https://drive.google.com/file/d/1-OPYNKlGj93tYqQ7Cx7UUDcsYO2PVKAh/view?usp=sharing) 
### What is a bootable USB stick with persistent storage?
A bootable USB with persistent storage is a USB drive that will boot up an OS and will retain the files and changes from the last time it is used. The actions performed while using the OS will be save to the USB and can be accessed again the next time the USB is booted.
### How does this fit into our project?
A bootable USB with persistent storage will be the vector for creating our thin client. Whenever a PC is to be used as a thin client, the USB will be plugged in, initialized via the BIOS, and our custom Xubuntu OS will boot up and automaically open the menu. The bootable USB will need persistent storage so that when changes are made in the OS by a user, they are not lost upon reboot. 
### Process (creating from Windows)
* Install and open [Rufus](https://rufus.ie/en/#)
* Select the Xubuntu ISO file
* Write the ISO
* Change settings so that "Persistent partition size" is at least 30% of your USB capacity
![Rufus Settings](https://github.com/WyattRuttle/OpenSourceThinClient/blob/main/RufusSettings.PNG?raw=true)
* boot from USB via BIOS
## How did we create the OS?
The OS is a lightweight setup that boots a custom YAD script designed by our team. Here are the steps in order:
1. Download Xubuntu Core and delete all unneccessary files.
2. Download required packages and dependances for scripts to run.
3. Download the menu script from github.
4. Create a user that auto logs in.
5. Configure XFE to automatically open our menu after the desktop has loaded on boot. 

We created a bash script to install all of the packages and dependencies automatically when executed:
```
# Update before installing packages
sudo apt-get update -y

# Install YAD
sudo apt-get install -y yad

# Install X2GO
sudo apt-get install x2goclient -y

# Install Remmina
sudo apt-get install remmina -y

# Install Wireguard
sudo apt-get install wireguard -y

# Install konsole
sudo apt-get install konsole -y

# Install xpra
sudo apt-get install xpra -y

# Install OpenVPN
sudo apt-get install openvpn -y
```
3. Setup Auto Login
* Edit lightdm.conf `sudo nano /etc/lightdm/lightdm.conf`
> `[SeatDefaults]
autologin-user=kiosk
autologin-user-timeout=0
user-session=ubuntu
greeter-session=unity-greeter`

* Run `sudo mkdir /etc/lightdm/lightdm.conf.d && sudo nano /etc/lightdm/lightdm.conf.d/50-myconfig.conf`
> `[SeatDefaults]
autologin-user=kiosk`
4. Set menu to run on boot
*  Make systemd unit file with .service extension in /etc/systemd/system
> `sudo nano /etc/systemd/system/kiosk.service`
* Contents of File:
```
[Unit]
Description=Make Kiosk Script Run On Boot
[Service]
ExecStart=/usr/bin/mainmenu.sh start
[Install]
WantedBy=multi-user.target
```

* Make the menu scripts executable: `chmod -R +x /path/to/menuscripts`
