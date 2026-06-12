# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --- Shell Options ---
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Magic space: !<something><space> expands last matching command
bind Space:magic-space

# --- Prompt ---
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
esac

# --- Aliases ---
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias diff='diff --color'
alias open='xdg-open'
alias xclip='xclip -selection c'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# --- Completion ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -x /usr/bin/mint-fortune ]; then
    /usr/bin/mint-fortune
fi

# --- Tools ---

# Conda
if [ -f "$HOME/anaconda3/bin/conda" ]; then
    __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    fi
    unset __conda_setup
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash

# --- Neovim (Docker) ---
NEOVIM_COMPOSE_DIR="$HOME/neovim/"

neovim_start_container() {
    make -C "${NEOVIM_COMPOSE_DIR}" up
}

neovim() {
    CONTAINER_ID=$(docker ps -q --filter name=neovim-neovim)
    if [ -z "${CONTAINER_ID}" ]; then
        neovim_start_container
        CONTAINER_ID=$(docker ps -q --filter name=neovim-neovim)
    fi

    VOL=/system
    CD_DIR=/${VOL}/$(pwd)
    PYTHON_PATH=$(dirname $(which python) 2> /dev/null)
    CARGO_PATH=$(dirname $(which cargo) 2> /dev/null)

    if [ -n "$1" ]; then
        VIM_DIR="/${VOL}/$(readlink -f "$1")"
        docker exec -it ${CONTAINER_ID} /bin/bash -l -c \
            "export PATH=\"${PYTHON_PATH}:${CARGO_PATH}:$PATH\" && cd ${CD_DIR} && nvim ${VIM_DIR}"
    else
        docker exec -it ${CONTAINER_ID} /bin/bash -l -c \
            "export PATH=\"${PYTHON_PATH}:${CARGO_PATH}:$PATH\" && cd ${CD_DIR} && nvim"
    fi
}

alias buildnvim="docker build -t neovim --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg LOCAL_UNAME=$(whoami) ."
alias n="neovim"
alias vim="neovim"
alias nvim="neovim"
alias vi="neovim"

# --- Personal ---
alias screen="$HOME/bashrc_vimrc/config/i3/screen.sh"
alias xampp="sudo /opt/lampp/lampp start"
alias audio="alsamixer"
alias audio-restart="pulseaudio -k && sudo alsa force-reload"
alias fix-audio="audio-restart"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
