# Welcome to OpenSourceThinClient

OpenSourceThinClient is a boot image which allows low-end PCs to be used as a thin-client to login to remote computers. The project is a modified version of Xubuntu Core that starts up into a simple menu for RDP and SSH services. The OS is as lightweight as possible so that it can be run using a USB with persistent storage. 

## Download the ISO and create a bootable USB
* [Thin Client ISO File](https://github.com/WyattRuttle/OpenSourceThinClient/releases) 
* [Documentation](https://brian-anderson01.gitbook.io/open-source-thin-client/)
### What is a bootable USB stick with persistent storage?
A bootable USB with persistent storage is a USB drive that will boot up an OS and will retain the files and changes from the last time it is used. The actions performed while using the OS will be save to the USB and can be accessed again the next time the USB is booted.
### How does this fit into our project?
A bootable USB with persistent storage will be the vector for creating our thin client. Whenever a PC is to be used as a thin client, the USB will be plugged in, initialized via the BIOS, and our custom Xubuntu OS will boot up and automaically open the menu. The bootable USB will need persistent storage so that when changes are made in the OS by a user, they are not lost upon reboot. 

### How do I boot the ISO now that I have it downloaded?
To boot your ISO from a USB device, click Documentation above. This will bring you to the site with walkthroughs on how to get your thin client set up.

## Want to build it yourself?
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
### Configure the menu to run on boot
* Download the required file from [here](https://github.com/WyattRuttle/OpenSourceThinClient/blob/release/startup.desktop)
* Make the menu scripts are executable: `chmod -R +x /path/to/menuscripts`
* Once downladed, edit the path on the `Exec` line so it points to the root folder of your scripts
* Now move the file to the autostart directory, `mv startup.desktop /etc/xdg/autostart`
* With the file moved there, everytime the system boots up the script will run once the user logs in.
