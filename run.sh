# /bin/bash

### BASH RC ###
cp ./.bashrc ~/.bashrc
source ~/.bashrc

### TMUX ###
cp ./.tmux.conf ~/.tmux.conf

### VIM ###
# Ultimate Vim rc install
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Move vimrc to home directory
cp ./.vimrc ~/.vimrc

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qal

# YouCompleteMe
sudo apt install build-essential cmake vim python3-dev # Install cmake, vim, python
cd ~/.vim/bundle/youcompleteme
python3 install.py --all # Will probably fail with some languages



### Other Software ###
# Anaconda
bash ./scripts/anaconda.sh
# Tmux
bash ./scripts/tmux.sh
