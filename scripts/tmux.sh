# /bin/bash

# Will need to run inside of tmux: prefix + I

echo "Tmux Plugin Manager Installer"

# Plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# Git status bar
sudo apt install golang-go
go get -u github.com/arl/gitmux


########## Help ##########
### Resurrect ###
# If need to restore to a previous tmux save:
#   1. Go to ~/.tmux/resurrect/
#   2. `ln -sf <Desired resurect> last`
#   3. Inside of tmux: prefix + Ctrl-r
# To save a tmux session
#   1. Inside of tmux: prefix + Ctrl-s
