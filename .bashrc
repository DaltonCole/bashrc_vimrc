# ~/.bashrc: executed by bash(1) for interactive non-login shells.
#
# Shared by desktops and headless servers, so every tool-specific block checks
# that its tool is installed first. Machine-specific aliases and settings go in
# ~/.bash_aliases, which is sourced last (see "Local overrides" at the bottom).

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --- History ---
HISTCONTROL=ignoreboth      # skip duplicate lines and lines starting with a space
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend         # append to the history file, don't overwrite it

# --- Shell options ---
shopt -s checkwinsize       # update LINES/COLUMNS after each command
shopt -s cdspell            # correct minor typos in `cd` arguments

# Magic space: `!<something><space>` expands the history reference in place
bind Space:magic-space

# Let less display non-text input files (archives, PDFs, ...)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# --- Prompt ---
# Name of the chroot you're working in, if any (shown in the prompt)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    if [ "$EUID" -eq 0 ]; then
        # root: red host, blue current directory name
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        # user: green user@host, blue full working directory
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt

# Set the terminal window title to "user@host dir"
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
        ;;
esac

# --- Colors ---
if [ -x /usr/bin/dircolors ]; then
    if [ -r "$HOME/.dircolors" ]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    # The fgrep/egrep commands are obsolescent and warn on every use since
    # GNU grep 3.8; `grep -F`/`grep -E` are the same thing without the warning.
    alias fgrep='grep -F --color=auto'
    alias egrep='grep -E --color=auto'
fi
alias diff='diff --color'

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# --- Aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Desktop helpers (just "command not found" where the tool isn't installed)
alias open='xdg-open'
alias xclip='xclip -selection c'    # use the clipboard, not the primary selection
# Desktop notification when a long command finishes, e.g. `sleep 10; alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# --- Completion ---
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# --- Tools ---

# Conda: use whichever of ~/miniconda3 or ~/anaconda3 is installed (miniconda3
# first). Same hook-then-conda.sh logic as the block `conda init` writes.
for __conda_root in "$HOME/miniconda3" "$HOME/anaconda3"; do
    if [ -f "$__conda_root/bin/conda" ]; then
        if __conda_setup="$("$__conda_root/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"; then
            eval "$__conda_setup"
        elif [ -f "$__conda_root/etc/profile.d/conda.sh" ]; then
            . "$__conda_root/etc/profile.d/conda.sh"
        fi
        break
    fi
done
unset __conda_root __conda_setup

# nvm (Node version manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"
fi

# Rust (rustup's cargo environment)
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# fzf key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd), Debian/Ubuntu path
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# --- Neovim (Docker or Podman) ---
# Neovim runs in a container built from the DaltonCole/neovim repo, cloned here.
NEOVIM_COMPOSE_DIR="$HOME/neovim/"

# Prints the engine that runs the neovim container: docker when a real Docker
# CLI is installed, otherwise podman. podman-docker's `docker` shim counts as
# Podman. Export NEOVIM_ENGINE=docker|podman to override. Same rule as the
# neovim repo's Makefile.
neovim_engine() {
    if [ -n "${NEOVIM_ENGINE}" ]; then
        echo "${NEOVIM_ENGINE}"
    elif command -v docker > /dev/null 2>&1 && ! docker --version 2> /dev/null | grep -qi podman; then
        echo docker
    elif command -v podman > /dev/null 2>&1; then
        echo podman
    else
        echo docker
    fi
}

# Finds the running container by its compose labels. The neovim repo pins the
# project name to "neovim", and both Docker and podman-compose set these.
neovim_container_id() {
    "${1:-$(neovim_engine)}" ps -q \
        --filter label=com.docker.compose.project=neovim \
        --filter label=com.docker.compose.service=neovim
}

# Starts the container through the neovim repo's Makefile, with the same engine.
neovim_start_container() {
    make -C "${NEOVIM_COMPOSE_DIR}" up NEOVIM_ENGINE="${1:-$(neovim_engine)}"
}

# Opens nvim in the container (starting it first if needed), in the current
# directory, with any files and options you pass. The container sees the host
# filesystem under /system.
neovim() {
    local engine id tool dir arg is_value="" only_files=""
    local vol=/system
    local path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    local -a args=()

    engine=$(neovim_engine)
    id=$(neovim_container_id "${engine}")
    if [ -z "${id}" ]; then
        neovim_start_container "${engine}"
        id=$(neovim_container_id "${engine}")
    fi

    # Add the host's active Python and cargo to the container's own PATH. Only
    # folders under $HOME exist at the same path in there.
    for tool in cargo python; do
        dir=$(dirname -- "$(command -v -- "${tool}")")
        case "${dir}" in "${HOME}"/*) path="${dir}:${path}" ;; esac
    done

    # File arguments become /system paths. Options and their values don't.
    for arg in "$@"; do
        if [ -n "${is_value}" ]; then
            is_value=""
            args+=("${arg}")
        elif [ -z "${only_files}" ] && [[ "${arg}" == [-+]* ]]; then
            case "${arg}" in
                --) only_files=1 ;;
                -c|--cmd|-t|-u|-i|-S|-s|-q|--listen|--server|--startuptime) is_value=1 ;;
            esac
            args+=("${arg}")
        else
            args+=("${vol}$(realpath -m -- "${arg}")")
        fi
    done

    "${engine}" exec -it -w "${vol}$(pwd -P)" -e PATH="${path}" "${id}" nvim "${args[@]}"
}

# Builds the neovim image from the current directory (run it in the neovim
# repo). A function rather than an alias so the engine is picked when it runs,
# not each time a shell starts. Extra arguments go to `build`.
buildnvim() {
    "$(neovim_engine)" build -t neovim --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg LOCAL_UNAME=$(whoami) "$@" .
}

# Every vi-style command opens the containerized neovim
alias n="neovim"
alias vim="neovim"
alias nvim="neovim"
alias vi="neovim"

# --- Local overrides ---
# Machine-specific aliases and settings that don't belong in this shared file.
# Sourced last so they can override anything above.
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi
