# /bin/bash

echo "Install i3"

# i3
sudo apt-get install i3
# i3-status
sudo apt-get install i3status
# i3 lock screen
sudo apt-get install i3lock
# i3 status bar customization
sudo apt-get install i3blocks
#   Battery in status bar
sudo apt-get install acpi
#   CPU usage
sudo apt install sysstat

# Dmenu
sudo apt-get install suckless-tools

# Background
sudo apt-get install feh

# Change system theme
sudo apt-get install lxappearance # Will need to manually change it via lxappearance


######### HELP #########
# Fit screen to monitor:
#   1. Install arandr
#   2. Run arandr, adjust things as desired, "Save As"
#   3. Copy shell file contents to i3 config file
# Auto-open program upon i3 start-up
#   1. Open desired application and terminal side-by-side
#   2. Run `xprop` in terminal and click on desired application
#   3. Use the second value from `WM_CLASS` in i3 config file


