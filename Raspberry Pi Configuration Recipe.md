Raspberry Pi Configuration Recipe
==================================
####Raspberry Pi OS Full 2021-10-30 (based on Debian bullseye)
####December 20, 2021

Install and configure Raspberry Pi OS:
-----------------------------------------------------------------------------------

1. Download the Raspberry Pi OS image to an unused micro SD card or USB drive:
 * Launch the Raspberry Pi Imager app on the Mac.
 * Insert the micro SD card into a reader on the Mac or connect the USB drive.
 * Select the Raspberry Pi OS (other) and then Raspberry Pi OS Full.
 * Select the SD card/USB drive.
 * Click Write and then Yes to allowing the card/drive to be overwritten.
 * Wait for the card/drive to be written and verified (about 10 min).
 * Click Continue, remove the card/drive, and quit the imager.
 
2. Boot the Raspberry Pi:
 * Connect a monitor and keyboard to the Raspberry Pi to be used in the initial configuration (steps 3-6).
 * Optionally connect the Pi to a wired ethernet port to facilitate initial downloads over the internet.
 * Insert the micro SD card or connect the USB drive and apply power to the Pi.
 * Wait for the boot to complete. 
3. Perform the initial configuration and update the distribution:
 * Click Next on the Raspberry Pi welcome window.
 * Set Country options and click Next to continue.
 * Enter and confirm a new password and click Next.
 * Check the box to fill the screen if necessary and then click Next.
 * Select a WiFi Network and click Next.
 * Enter the WiFi Password and click Next.
 * Click Next to update the distribution.
 * Click OK when the system is up to date then Restart.

 ```
If the above update fails to complete successfully, click Back and start it again. If the problem persists, perform the following steps to manually update the distribution:
```
 * Open a terminal window in the pi home directory.
 * **sudo apt --allow-releaseinfo-change update**
 * **sudo apt dist-upgrade**
 * **sudo apt autoremove**
 * Click Shutdown in the Applications menu and then Reboot.

4. Setup the pi desktop:
 * Right-click on the menu bar and then select Panel Settings. 
 * Click Geometry/Bottom to move the panel to the bottom of the screen.
 * Select Panel Applets and then click Add/Remove/Up/Down to configure the following applets: (1) Menu, (2) System Tray, (3) Application Launch Bar, (4) Spacer, (5) Task Bar - stretch, (6) Updater, (7) Ejecter, (8) Bluetooth, (9) Wireless & Wired Network, (10) Volume Control, (11) CPU Usage Monitor, (12) CPU Temperature Monitor, (13) CPUFreq frontend, and (14) Digital Clock.
 * Select CPU Usage Monitor/Preferences and then click Show usage as percentage.
 * Select Application Launch Bar/Preferences and then click Add/Remove/Up/Down to configure the application launch bar as follows: (1) File Manager, (2) Task Manager, (3) Terminal (4) VNC Viewer, (5) Web Browser, (6) Claws Mail, (7) Text Editor, (8) PDF Viewer, (9) Mathematica, (10) Scratch 3, (11) Thonny Python IDE, and (12) Wolfram.
 * Close the Application Launch Bar and Panel Preferences windows.
 * Move the Trash to the lower right of the desktop.
 * From the Main Menu select Preferences, Appearance Settings, Desktop and then select a new desktop photo.

5. Continue the configuration using menu options:
 * From the Main Menu select Preferences and then Raspberry Pi Configuration.
 * In the System tab click in the Hostname box and set the Hostname for this Raspberry Pi.
 * Select the Display tab and then select a Headless Resolution of 1920x1080.
 * Moving to the Interfaces tab, select Enabled for all interfaces except the Serial Console and 1-Wire which should be Disabled.
 * Click OK and then Yes to reboot and apply the settings.
 * Right-click on the leftmost VNC icon in the panel and click Options.
 * Click Expert and scroll to the IdleTimeout parameter.
 * Set IdleTimeout to 0 and click Apply.
 * Click OK to close the VNC Server Options window.
  
 ```
At this point, the configuration procedure can be continued using the VNC Viewer on the Mac.  If desired, shutdown the Pi, remove the power, remove the monitor and keyboard, and then restore the power to boot for VNC-only operation.
```

Configure local options:
-----------------------------------------------------------------------------------
1. Install the afp server, printer software, comm, stress testing tools, et al:
 * Open a terminal window in the pi home directory.
 * **sudo apt install automake netatalk hplip-gui telnet ttf-mscorefonts-installer**
 * Reply Y to complete the installation.
 * **sudo apt autoremove**
 * Reply Y to complete the operation.
 
2. Install optional Python packages:
 * **sudo pip3 install adafruit-circuitpython-ssd1306**
 
3. Enable and start the pigpio server daemon (pigpiod):
 * **sudo systemctl enable pigpiod**
 * **sudo systemctl start pigpiod**
 * **systemctl status pigpiod**
 
4. Give the user pi permission to administer printers and faxes:
 * **sudo usermod -aG lpadmin pi**
 
5. Install the bash-scripts package, including papamac's bash aliases, scripts, and the netatalk afp.config file.
 * **git clone https://github.com/papamac/bash-scripts**
 * **chmod +x bash-scripts/p2pkg**
 * **cd /usr/local**
 * **sudo -E ~/bash-scripts/p2pkg -gio bash-scripts**
 * Reply Y to confirm the working directory.
 * **sudo rm -r ~/bash-scripts**
 
6. Reboot to enable bash-scripts:
 * **reboot**

Add HP printers and faxes:
----------------------------------------------------------------------------------- 
1. Add Bonjour/avahi-discoverable devices:
 * From the Applications Menu, select Preferences and then HPLIP Toolbox.  A window will pop up with the message “No Installed HP Devices Found.”
 * Click “Setup Device…” and select the “Network/Ethernet/Wireless…” connection type.
 * Click Next and follow the instructions to add the first discoverable printer/fax.
 * After the first printer/fax is added, the HP Device Manager window will reappear.
 * Click the “+” icon, select the “Network/Ethernet/Wireless…” connection type, click Next, and repeat the process until all discoverable devices have been added.

2. Add non-discoverable devices (if any):
 * On the mac, use Network Radar to find the DHCP-assigned IP addresses of all non-discoverable devices.
 * In the HP Device Manager window, click the “+” icon and select the “Network/Ethernet/Wireless…” connection type.
 * Click Show Advanced Options, check Manual Discovery, and enter the IP address of the first non-discoverable device.
 * Click Next and continue to add the first non-discoverable device.
 * Repeat the process if needed for any additional devices.
 * Close the HP Device Manager window.

```
At this point the disk image can be cloned by launching the SD Card Copier from Menu/Accessories.  This is useful if boot disks for multiple Raspberry Pi's are to be created using this basic configuration.  The SD Card Copier requires an empty SD card or USB drive as the copy destination.  If needed, the Raspberry Pi Imager app can be used to erase an SD card or USB drive on the Mac.

Note that there are issues in cloning a disk image built on a Pi 4b and then using it on a Pi 3b+.  One issue is that the VNC screen resolution cannot be expanded on the Pi 3b+.  There may be other issues as well.  It's best to build/clone a disk image on the same Pi model as the intended target.
```


Optionally install papamac packages:
----------------------------------------------------------------------------------
1. Select the /usr/local directory for the installation:
 * Open a terminal window.
 * **c /usr/local**
2. Download the papamaclib package from github:
 * **sudo p2pkg -g papamaclib**
 * Reply Y to confirm the working directory.
3. Optionally download and install the messagesocket package:
 * **sudo p2pkg -gi messagesocket**
 * Reply Y to confirm the working directory.
4. Optionally download and install the PiDACS package:
 * Identify the hardware devices to be used by PiDACS and their relative hardware addresses.  The relative addresses are hardwired or jumper selectable on the I/O boards. They are typically in the range 0-7 and are represented by the character "#" in the table  below. Use the table to determine the port names for the devices.  For example, ab0 and ab1 are the port names of two MCP3424 devices with relative addresses 0 and 1.

 ```
     Device     |                Description                         |Port Name
------------|----------------------------------------------------|----------
BCM2835,6,7 |Baseline GPIO set (GPIOs 17-18, 22-25, 27)          |   gp0
BCM2835,6,7 |Extended GPIO set (GPIOs 5-6, 12-13, 16, 19-21, 26) |   gp1
MCP23008    |8-Bit I/O Expander                                  |   ga#
MCP23017    |16-Bit I/O Expander (A Port)                        |   ga#
MCP23017    |16-Bit I/O Expander (B Port)                        |   gb#
MCP3204     |4-Channel 12-Bit A/D Converter                      |   ad#
MCP3208     |8-Channel 12-Bit A/D Converter                      |   ae#
MCP3422,3   |2-Channel 18-Bit A/D Converter                      |   aa#
MCP3424     |4-Channel 18-Bit A/D Converter                      |   ab#
MCP4821     |1-Channel 12-Bit D/A Converter                      |   da#
MCP4822     |2-Channel 12-Bit D/A Converter                      |   db#
```
 * All Raspberry Pi's have built-in GPIO channels. These are divided into two sets: a Baseline GPIO set with 7 GPIO channels on the original Pi models and an additional Extended GPIO set with 9 channels on current models. The port names for these two sets are gp0 for the Baseline set and gp1 for the Extended set.
 * Make a list of the three-character port names to be processed by PiDACS on this Raspberry Pi.  The list will be entered in the p2pkg command below as individual arguments separated by spaces, for example, ab0 ab1 ga0 gb0 gp0 gp1. 
 * **sudo p2pkg -gio PiDACS port1 port2... portn**
 * Reply Y to confirm the working directory.
5. Optionally download and install the scale package:
 * **sudo p2pkg -gio scale**
 * Reply Y to confirm the working directory.
6. Optionally download and install the ser2sock and ser2sock-scripts packages:
 * **sudo p2pkg -G nutechsoftware ser2sock**
 * Reply Y to confirm the working directory.
 * **sudo p2pkg -gio ser2sock-scripts**
 * Reply Y to confirm the working directory.
7. Confirm startup of any installed daemons:
 * **reboot**
 * **systemctl status daemon_name** (e.g., pidacsd, scaled, ser2sockd)

Optionally install BitScope DSO:
-----------------------------------------------------------------------------------

1. Download and install the latest BitScope DSO installation package:
 * Launch the Web Browser and go to www.bitscope.com.
 * Click Downloads then Download and select from the pulldown menus:
 Release: Production
 Operating Systems: Ubuntu Raspbian Debian
 CPU Architecture: ARMv7 (ARMv6+)
 * Select `bitscope-dso_2.8.FE22H_armhf.deb` from the file list and click Download.
 * From the “File Download Links” page click Download again and then Keep to (finally) get the file.
 * Use the File Manager to view the Downloads folder and identify the Debian package file (*.deb). 
 * Install BitScope DSO by double-clicking on the package file and following the instructions.

2. Change the application category to "Other":
 * Open a terminal window.
 * **cdl /usr/share/applications**
 * **sudo nano bitscope-dso.desktop**
 * Remove the Category “Development” from the second to last line.  This forces BitScope DSO to appear in the “Other” applications folder.
 * Save and exit (\^o return \^x).

3. Add BitScope DSO to the Application Launch Bar:
 * Right-click on the menu bar and then click Panel Settings.
 * Select Panel Applets, Application Launch Bar, and then Preferences
 * In the Other list choose BitScope DSO and add it to the end of the Application Launch Bar.



Optionally install alarmdecoder and alarmdecoder-webapp:
---------------------------------------------------------------------------------
```
This procedure does not work yet; it needs to be debugged.
```

1. Install/upgrade Debian and Python packages:
 * **sudo apt-get install cmake cmake-data libffi-dev libpcre3-dev libpcre++-dev libcurl4-openssl-dev sqlite3 screen vim nginx gunicorn miniupnpc python-virtualenv python-opencv python-httplib2**
 * **sudo pip install --upgrade pip**
 * **sudo pip install --upgrade setuptools**

2. Create needed directories and set permissions for updates:
 * **sudo mkdir -p /opt/alarmdecoder /opt/alarmdecoder-webapp**
 * **sudo chown pi:pi /opt/alarmdecoder /opt/alarmdecoder-webapp**

3. Get the latest alarmdecoder and alarmdecoder-webapp:
 * **cdl /opt**
 * **git clone https://github.com/nutechsoftware/alarmdecoder.git**
 * **git clone https://github.com/nutechsoftware/alarmdecoder-webapp.git**

4. Add Python requirements to the entire system as root:
 * **cdl alarmdecoder-webapp**
 * **sudo pip install -r requirements.txt**

5. Give the pi user r/w access to key files for the WEB services:
 ```
In the baseline distribution, pi has access to serial ports as a member of the dialout group. Change the group access for the hosts and hostnames files to r/w for group dialout to give pi r/w access.
``` 
 * **sudo chgrp dialout /etc/hosts /etc/hostname**
 * **sudo chmod g+w /etc/hosts /etc/hostname**
 
6. Enable the avahi service:
 * **echo -e '<?xml version="1.0" standalone="no"?>\n<!DOCTYPE service-group SYSTEM "avahi-service.dtd">\n<service-group>\n\t<name replace-wildcards="yes">%h</name>\n\t<service>\n\t\t<type>_device-info._tcp</type>\n\t\t<port>0</port>\n\t\t<txt-record>model=AlarmDecoder</txt-record>\n\t</service>\n\t<service>\n\t\t<type>_ssh._tcp</type>\n\t\t<port>22</port>\n\t</service>\n</service-group>' | sudo tee /etc/avahi/services/alarmdecoder.service**

7. Create nginx ssl folder:
 * **sudo mkdir -p /etc/nginx/ssl**

8. Remove all default web content:
 * **sudo rm -r /var/www/html**

9. Enable gunicorn service and tuning for Alarmdecoder webapp:
 * **echo -e '[Unit]\nDescription=gunicorn daemon\nAfter=network.target\n\n[Service]\nPIDFile=/run/gunicorn/pid\nUser=pi\nGroup=dialout\nWorkingDirectory=/opt/alarmdecoder-webapp\nExecStart=/usr/bin/gunicorn --worker-class=socketio.sgunicorn.GeventSocketIOWorker --timeout=120 --env=POLICY_SERVER=0 --log-level=debug wsgi:application\nExecReload=/bin/kill -s HUP $MAINPID\nExecStop=/bin/kill -s TERM $MAINPID\nPrivateTmp=true\n\n[Install]\nWantedBy=multi-user.target\n' | sudo tee /etc/systemd/user/gunicorn.service**

10. Enable gunicorn server and set to start at boot:
 * **sudo ln -s /etc/systemd/user/gunicorn.service /etc/systemd/system/multi-user.target.wants/gunicorn.service**
 * **sudo ln -s /etc/systemd/user/gunicorn.service /etc/systemd/system/gunicorn.service**

11. Enable log rotate for webapp and gunicorn:
 * **echo -e '/opt/alarmdecoder-webapp/instance/logs/*.log {\nweekly\nmissingok\nrotate 5\ncompress\ndelaycompress\nnotifempty\ncreate 0640 pi pi\nsharedscripts\n\ }' > /etc/logrotate.d/alarmdecoder
sudo echo -e '/var/log/gunicorn/*.log {\nweekly\nmissingok\nrotate 5\ncompress\ndelaycompress\nnotifempty\ncreate 0640 www-data www-data\nsharedscripts\npostrotate\n[ -s /run/gunicorn/alarmdecoder.pid ] && kill -USR1 `cat /run/gunicorn/alarmdecoder.pid`\nendscript\n}' | sudo tee /etc/logrotate.d/gunicorn**

12. Create gunicorn app config directory and add our app configuration:
 * **sudo mkdir /etc/gunicorn.d**
 * **sudo cp /opt/alarmdecoder-webapp/contrib/gunicorn.d/alarmdecoder /etc/gunicorn.d**

13. Generate an ssl certificate for the webapp:
 * **sudo openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:4096 -keyout /etc/nginx/ssl/alarmdecoder.key -out /etc/nginx/ssl/alarmdecoder.crt -subj '/CN=AlarmDecoder.local/O=AlarmDecoder.com/C=US'**

14. Add nginx service configuration for the webapp:
 * **sudo cp /opt/alarmdecoder-webapp/contrib/nginx/nginx.service /lib/systemd/system/nginx.service**

15. Remove the default site and add the alarmdecoder nginx site configuration and enable it:
 * **sudo rm /etc/nginx/sites-enabled/default**
 * **sudo cp /opt/alarmdecoder-webapp/contrib/nginx/alarmdecoder /etc/nginx/sites-available**
 * **sudo ln -s /etc/nginx/sites-available/alarmdecoder /etc/nginx/sites-enabled**

16. Init the AD2Web database as pi user:
 * **cdl /opt/alarmdecoder-webapp**
 * **python manage.py initdb**