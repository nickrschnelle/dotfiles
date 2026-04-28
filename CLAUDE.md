# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation

```bash
# Full install: install all dependencies + symlink configs
./install.sh

# Skip dependency installation (linking only)
./install.sh -d
```

`install.sh` calls `deps.sh` (dependencies) then `linking.sh` (config symlinks).

## How linking works

`linking.sh` creates each `~/.config/<tool>/` directory and symlinks the **contents** of `.config/<tool>/` into it (individual files are linked, not the directory itself). Managed tools: `wezterm`, `nvim`, `tmux`, `sesh`, `fish`.

`bat` config lives in `.config/` but is **not** managed by `linking.sh` — link manually if needed.

## Dependency stack (`deps.sh`)

Targets macOS (Homebrew) as primary; Linux Homebrew supported as a secondary path. Key installs:

- **Shell**: fish (default shell), fisher + plugins from `fish_plugins`
- **Terminal**: wezterm (external install), tmux
- **Editor**: neovim v0.11.1 (built from source — not Homebrew)
- **Navigation/search**: fzf + fzf-git (`~/bin/fzf-git.sh`), fd, zoxide, eza
- **Utilities**: bat + Catppuccin Frappe theme, sesh
- **Fonts**: Hack Nerd Font (via `brew install --cask` on Mac, direct download on Linux)

## Fish config and the tmux PATH issue

Fish only reads `~/.config/fish/config.fish` — it must be named exactly that. The previous `fish.config` name was never loaded.

`config.fish` uses `fish_add_path` (runs for **all** sessions — interactive, non-interactive, tmux new-window) to set Homebrew and `~/.local/bin` paths before any `status is-interactive` check. This ensures tools like `claude`, `nvim`, and `zoxide` are on PATH in every tmux window/pane.

## Config locations

| Tool | Config path |
|------|-------------|
| Neovim | `.config/nvim/init.lua` |
| tmux | `.config/tmux/tmux.conf` |
| WezTerm | `.config/wezterm/wezterm.lua` |
| fish | `.config/fish/config.fish`, `fish_plugins` |
| sesh | `.config/sesh/sesh.toml` |
| bat | `.config/bat/` |

## Adding a new tool

1. Add config files under `.config/<tool>/`
2. Add `link_dir <tool>` to `linking.sh`
3. Add install logic to `deps.sh` if needed
