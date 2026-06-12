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
| `.bashrc` | `~/.bashrc` | Bash config, aliases, conda/nvm/cargo init |
| `.tmux.conf` | `~/.tmux.conf` | Tmux config with TPM plugins |
| `.vimrc` | `~/.vimrc` | Legacy vim config (amix/vimrc based) |
| `.config/nvim/init.vim` | `~/.config/nvim/init.vim` | Primary neovim config |
| `config/i3/` | `~/.config/i3/` | i3 WM config and i3blocks status bar |

## Neovim Architecture

Plugin manager: **vim-plug** (`call plug#begin` / `call plug#end`). Plugins auto-install on first launch.

**Leader key**: `,`

Key plugin bindings:
- `,f` — MRU (most recently used files)
- `,o` — BufExplorer
- `,nn` / `,nf` — NERDTree toggle / find
- `Ctrl+f` / `,j` — CtrlP fuzzy file finder
- `gd` / `gr` / `K` — coc.nvim go-to-definition / references / hover docs
- `crn` — coc.nvim symbol rename
- `[g` / `]g` — navigate ALE/coc diagnostics
- `,a` — jump to next ALE error
- `,g` — toggle GitGutter
- `,v` / `,s` — vertical / horizontal split

**LSP/completion**: coc.nvim handles autocomplete and LSP. ALE handles linting with:
- Rust: `rust-analyzer`
- Python: `flake8`
- JavaScript: `eslint`
- Go: `go`, `golint`, `errcheck`

**Rust**: `rustfmt` runs on save (`let g:rustfmt_autosave = 1`).

**Neovim runs in Docker** (see `.bashrc` `neovim()` function). The aliases `vim`, `nvim`, `vi`, `n` all invoke the Docker-based neovim. The container mounts `/system` and maps the host filesystem under that prefix.

## Tmux Key Notes

- Prefix + `v`/`s` — vertical/horizontal split (preserves cwd)
- `Alt+hjkl` — switch panes without prefix
- `Shift+Left/Right` — switch windows
- `Alt+1-9` — jump to window by number
- `Alt+J/K` — swap window left/right
- `prefix + r` — reload tmux config
- `prefix + I` (capital I) — install TPM plugins
- Status bar uses Mountain Time (America/Denver)

## Bash Aliases of Note

- `n` / `vim` / `nvim` / `vi` — all invoke dockerized neovim
- `cluster` — SSH to pi cluster
- `screen` — run `config/i3/screen.sh` for dual-monitor setup
- `xampp` — start XAMPP/LAMPP server
- `audio-restart` / `fix-audio` — fix PulseAudio renderer errors
- `xclip` — copy to clipboard via xclip (uses `-selection c`)
- `diff` — colored diff
