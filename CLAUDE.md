# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles/configuration repository for a Linux desktop environment. It covers bash, neovim, tmux, and i3 window manager.

## Deploying Configs

`run.sh` is the main install script — it copies dotfiles to `~` and installs vim/vundle. Run it from the repo root:

```bash
bash run.sh
```

For initial system setup (requires sudo):
```bash
bash me_first_apt_installs_need_sudo.sh
```

Per-tool install scripts live in `scripts/`:
- `scripts/tmux.sh` — installs TPM and gitmux (run inside tmux, then `prefix + I` to install plugins)
- `scripts/i3.sh` — installs i3, i3blocks, rofi, feh, etc.
- `scripts/vim.sh` — sets flake8 max line length to 120

## File Map

| File | Target | Purpose |
|------|--------|---------|
| `.bashrc` | `~/.bashrc` | Bash config: prompt, aliases, completion, conda/nvm/cargo/fzf init, containerized-neovim launcher |
| `.tmux.conf` | `~/.tmux.conf` | Tmux config with TPM plugins |
| `config/i3/` | `~/.config/i3/` | i3 WM config and i3blocks status bar |

## Neovim

The neovim config itself is not in this repo. It lives in the separate `DaltonCole/neovim` repo (cloned to `~/neovim`, the `.bashrc`'s `NEOVIM_COMPOSE_DIR`), which also builds the container image. This repo only has the `.bashrc` launcher.

**Neovim runs in a container, under Docker or Podman** (see the `.bashrc` `neovim()` function). The aliases `vim`, `nvim`, `vi`, `n` all invoke the containerized neovim. `neovim_engine()` picks Docker when a real Docker CLI is installed, otherwise Podman (podman-docker's `docker` shim counts as Podman); export `NEOVIM_ENGINE=docker|podman` to override. The container is found by its compose labels (project `neovim`), and is started via the neovim repo's Makefile with the same engine. The container mounts `/system` and maps the host filesystem under that prefix.

## Tmux Key Notes

- Prefix + `v`/`s` — vertical/horizontal split (preserves cwd)
- `Alt+hjkl` — switch panes without prefix
- `Shift+Left/Right` — switch windows
- `Alt+1-9` — jump to window by number
- `Alt+J/K` — swap window left/right
- `prefix + r` — reload tmux config
- `prefix + I` (capital I) — install TPM plugins
- Status bar uses Mountain Time (America/Denver)

## Bash Notes

`.bashrc` is shared by desktops and headless Ubuntu servers (the `DaltonCole/new-machine-setup` Ansible playbook deploys it), so:
- the non-interactive early `return` stays at the top
- every tool-specific block checks that the tool is installed first
- no hardcoded home paths; use `$HOME`
- nothing machine-specific: that goes in `~/.bash_aliases` (not in this repo), which is sourced last so it can override anything

Section order: history, shell options, prompt, colors, aliases, completion, tools (conda from `~/miniconda3` or else `~/anaconda3`, then nvm, cargo, fzf), neovim, local overrides (`~/.bash_aliases`).

Aliases of note:
- `n` / `vim` / `nvim` / `vi` — all invoke containerized neovim (Docker or Podman); the `buildnvim` function builds its image from the current directory
- `open` — `xdg-open`
- `xclip` — copy to clipboard via xclip (uses `-selection c`)
- `alert` — desktop notification when a command finishes (`sleep 10; alert`)
- `diff` — colored diff; `fgrep` / `egrep` — `grep -F` / `grep -E` with color
