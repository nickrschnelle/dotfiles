# update apt
apt update
apt upgrade

# terminal
## wezterm
https://wezterm.org/install/linux.html#__tabbed_1_3

## install zsh
apt install zsh
chsh -s $(which zsh)
## install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

TODO: copy eval line from zshrc
TODO: store config file


## homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
TODO: add this to .zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/nsc/.zshrc

## fzf
brew install fzf

## fd - better find
brew install fd
TODO: config in zshrc

## bat
brew install bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
bat cache --build

## zoxide - better cd
brew install zoxide
TODO: eval "$(zoxide init zsh)" in zshrc

## eza
brew install eza
TODO: copy alias from zshrc

## neovim
### deps
sudo apt-get install ninja-build gettext cmake curl build-essential
### install
mkdir ~/bin/neovim
cd ~/bin/neovim
git clone https://github.com/neovim/neovim .
git checkout v0.11.1
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

## tmux
brew install tmux
### need python for deps TODO: maybe not?
sudo apt install python3-pip
python3 -m pip install --user libtmux
### tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
TODO: zshrc
### sesh
brew install sesh
TODO: instructions to build from source
### catppuccin theme
TODO: just commit this to source control
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux



# font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
