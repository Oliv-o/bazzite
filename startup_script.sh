echo Initializing Gaming Station


echo Disable Gnome
sudo systemctl disable gdm




echo Start User app
WAYALND_DISPLAY_"" ./ES-DE_x64.AppImage


#Generate systemd unit
""" 
[Unit]
#The # is a comment line
#Documentation https://www.freedesktop.org/software/systemd/man/systemd.service.html

#Place short description here
Description=My IOT Device Service

#This will not start execution of this file until the network connection is made
#It can be replaced with other parameters of your choosing
After=network.target

[Service]
#Default: Startup type
Type=Simple

#Edit this with your file name. In this example the app executable is in the /home/pi/myiotappfolder
#The file we are running and made executable is <myiotapp>
#ExecStart runs this executable script
ExecStart=WAYLAND_DISPLAY="" /home/olio/ES-DE_x64.AppImage

#Optional: Saves the output and error log of the terminal to a .log file in a directory of your choosing.
StandardOutput=file:/home/pi/myiotapp.log
StandardError=file:/home/pi/myiotapp-error.log

#Optional: To cleanly end the file on stop use this command. This sends a terminal interrupt command on the executable script
KillSignal=SIGINT

#Automatically restart on kill
Restart=always

[Install]
WantedBy=multi-user.target
"""

#With root copy the file
cp gamestation.service /etc/systemd/system

#and give execution permissions
chmod +x gamestation.service


#Set autologin for console
sudo systemctl edit getty@tty1

"""
[Service]
ExecStart=
ExecStart=-/usr/sbin/agetty --autologin your_user_name --noclear %I $TERM

"""