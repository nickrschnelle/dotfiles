#!/bin/bash
return_dir=$PWD

check() {
  command -v "$1" >/dev/null 2>&1
}

install_if_missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Installing $1..."
    shift
    "$@"
  else
    echo "$1 is already installed."
  fi
}

echo "Updating apt"
sudo apt update
sudo apt upgrade

echo "Creating $HOME/bin"
mkdir -p $HOME/bin

echo "Installing dependencies"
echo "Installing zsh"
sudo apt install zsh
chsh -s $(which zsh)

# TODO: needed?
#
#echo "Installing Oh My Zsh"
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Oh My Posh"
install_if_missing oh-my-posh curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

echo "Installing homebrew"
install_if_missing brew /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "Installing fzf"
install_if_missing fzf brew install fzf

echo "Installing fd"
install_if_missing fd brew install fd

echo "Installing bat"
if ! check "bat"; then
  brew install bat 
  mkdir -p "$(bat --config-dir)/themes"
  wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
  bat cache --build
else
  echo "bat is already installed"
fi

echo "Installing fzf-git"
cd $HOME/bin
git clone https://github.com/junegunn/fzf-git.sh.git
cd $return_dir

echo "Installing zoxide"
install_if_missing brew install zoxide

echo "Installing eza"
brew install eza

if ! check "nvim"; then
  echo "Installing neovim deps"
  apt-get install ninja-build gettext cmake curl build-essential
  mkdir p ~/bin/neovim
  cd ~/bin/neovim
  git clone https://github.com/neovim/neovim .
  git checkout v0.11.1
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  make install
  cd $return_dir 
else
  echo "nvim is already installed"
fi

echo "Installing tmux"
install_if_missing tmux brew install tmux

echo "Installing fonts"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
cd $return_dir
