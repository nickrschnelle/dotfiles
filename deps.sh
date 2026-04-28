#!/bin/bash
return_dir=$PWD

is_mac() { [[ "$(uname)" == "Darwin" ]]; }
is_linux() { [[ "$(uname)" == "Linux" ]]; }
is_arch() { check pacman && [[ -f /etc/arch-release ]]; }

check() { command -v "$1" >/dev/null 2>&1; }

brew_install() {
  local bin="$1"; shift
  local pkgs=("${@:-$bin}")
  if ! check "$bin"; then
    echo "Installing $bin..."
    brew install "${pkgs[@]}"
  else
    echo "$bin is already installed."
  fi
}

pacman_install() {
  local bin="$1"; shift
  local pkgs=("${@:-$bin}")
  if ! check "$bin"; then
    echo "Installing $bin..."
    sudo pacman -S --noconfirm "${pkgs[@]}"
  else
    echo "$bin is already installed."
  fi
}

# ── Package manager bootstrap ────────────────────────────────────────────────
if is_arch; then
  # Arch: use pacman for system build tools, then install Homebrew on top
  if ! check gcc; then
    sudo pacman -S --noconfirm base-devel
  fi
elif is_linux; then
  if ! check gcc; then
    sudo apt-get update && sudo apt-get install -y build-essential
  fi
fi

if ! check brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if is_mac; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ── tmux plugin manager ──────────────────────────────────────────────────────
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "Installing tpm..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# ── Shell ────────────────────────────────────────────────────────────────────
brew_install fish
# Set fish as default shell if not already
if [[ "$SHELL" != *fish* ]]; then
  fish_path="$(command -v fish)"
  if ! grep -qF "$fish_path" /etc/shells; then
    echo "Adding $fish_path to /etc/shells..."
    echo "$fish_path" | sudo tee -a /etc/shells
  fi
  echo "Changing default shell to fish..."
  chsh -s "$fish_path"
fi

# ── Fisher (fish plugin manager) + plugins ───────────────────────────────────
if ! fish -c "type -q fisher" 2>/dev/null; then
  echo "Installing fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi
echo "Installing fish plugins from fish_plugins..."
fish -c "fisher update" 2>/dev/null || true

# ── Core tools ───────────────────────────────────────────────────────────────
brew_install fzf
brew_install fd
brew_install zoxide
brew_install eza
brew_install tmux
brew_install sesh

# fzf-git
if [[ ! -d "$HOME/bin/fzf-git.sh" ]]; then
  echo "Installing fzf-git..."
  git clone https://github.com/junegunn/fzf-git.sh.git "$HOME/bin/fzf-git.sh"
else
  echo "fzf-git is already installed."
fi

# ── bat + Catppuccin theme ────────────────────────────────────────────────────
if ! check bat; then
  brew install bat
fi
bat_themes="$(bat --config-dir)/themes"
if [[ ! -f "$bat_themes/Catppuccin Frappe.tmTheme" ]]; then
  echo "Installing bat Catppuccin Frappe theme..."
  mkdir -p "$bat_themes"
  curl -fsSL -o "$bat_themes/Catppuccin Frappe.tmTheme" \
    "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme"
  bat cache --build
fi

# ── Neovim (from source) ─────────────────────────────────────────────────────
if ! check nvim; then
  echo "Installing Neovim build dependencies..."
  if is_mac; then
    brew install ninja cmake gettext curl
  elif is_arch; then
    pacman_install ninja
    pacman_install cmake
    pacman_install gettext
    brew_install curl
  else
    sudo apt-get install -y ninja-build gettext cmake curl build-essential
  fi
  mkdir -p "$HOME/bin/neovim"
  git clone https://github.com/neovim/neovim "$HOME/bin/neovim"
  cd "$HOME/bin/neovim"
  git checkout v0.11.1
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd "$return_dir"
else
  echo "nvim is already installed."
fi

# ── Fonts ─────────────────────────────────────────────────────────────────────
if is_mac; then
  if [[ ! -d "$HOME/Library/Fonts/HackNerdFont-Regular.ttf" ]]; then
    echo "Installing Hack Nerd Font..."
    brew install --cask font-hack-nerd-font
  fi
else
  font_dir="$HOME/.local/share/fonts"
  if [[ ! -f "$font_dir/HackNerdFont-Regular.ttf" ]]; then
    echo "Installing Hack Nerd Font..."
    mkdir -p "$font_dir"
    curl -fLo "$font_dir/HackNerdFont-Regular.ttf" \
      "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf"
    curl -fLo "$font_dir/HackNerdFontMono-Regular.ttf" \
      "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf"
    fc-cache -f "$font_dir"
  fi
fi

cd "$return_dir"
