## Welcome to OpenSourceThinClient

OpenSourceThinClient is a boot image which allows low-end PCs to be used as a thin-client to login to remote computers. The project is a modified version of Xubuntu Core that starts up into a simple menu for RDP and SSH services. The OS is as lightweight as possible so that it can be run on low requirements using a USB with persistent storage. 

# How did we create the OS?
The OS is a traditional Kiosk setup that boots into a custom YAD script. Here are the steps in order:
1. Download Xubuntu Core and delete all unneccessary files
2. Download required software for the menu
3. Download the menu script
4. Create a user that auto logs in
5. Make a script that runs on boot to open the menu and hide the rest of the desktop. 
## What is a Kiosk?
A kiosk is a full-screen application running on a secure/low privilege device, with the sole purpose of providing one specific function. 
## How does this fit our project?
For this project we are considering using Ubuntu kiosk in combination with a live boot persistent USB. Ubuntu Kiosk will make the image on our flash drive become more secure, low privelege, and will display our four option menu on start. Most Kiosks made using Ubuntu boot into a modified chromium browser that then display the information. This is because most kiosk are used for customers to see maps, fill out forms, and perform simple tasks. To make this work for our project, our kiosk will not boot into chromium. Our kiosk will boot into our custom YAD menu that displays our four programs and allows the user to then RDP into another machine. 
## Kiosk Creation Process
1. create user named "kiosk"
2. Install applications for menu:
* YAD
* Remmina
* X2Go
* XRPA
* WireGuard
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
*  make systemd unit file with .service extension in /etc/systemd/system
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

* Make the menu script executable: `chmod +x mainmenu.sh`










```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```