# /bin/bash

# Will need to run inside of tmux: prefix + I

echo "Tmux Plugin Manager Installer"

# Plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# Git status bar
sudo apt install golang-go
go get -u github.com/arl/gitmux
