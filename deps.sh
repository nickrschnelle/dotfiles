#!/bin/bash
return_dir=$PWD

echo "Updating apt"
apt update
apt upgrade

echo "Creating $HOME/bin"
mkdir -p $HOME/bin

echo "Installing dependencies"
echo "Installing zsh"
apt install zsh
chsh -s $(which zsh)

echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Oh My Posh"
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source ~/.zshrc

echo "Installing fzf"
brew install fzf

echo "Installing fd"
brew install fd

echo "Installing bat"
brew install bat 
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
bat cache --build

echo "Installing zoxide"
brew install zoxide

echo "Installing eza"
brew install eza

echo "Installing neovim deps"
apt-get install ninja-build gettext cmake curl build-essential
mkdir p ~/bin/neovim
cd ~/bin/neovim
git clone https://github.com/neovim/neovim .
git checkout v0.11.1
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd $return_dir 

echo "Installing tmux"
brew install tmux

echo "Installing fonts"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
cd $return_dir
