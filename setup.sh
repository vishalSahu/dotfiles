#! /usr/bin/env bash

# Other similar setups
# 1. https://gist.github.com/nickytonline/729fc106a0146345c0b90f3356a41e4d
# 2. https://github.com/smitmartijn/MacOS-Setup/blob/master/install_apps.sh

# prompt for sudo password at the beginning
sudo echo "Please enter password for sudo: "

# setup macos
read -p "Update macos settings (y/N): " update
echo $update
if [ "$update" = "y" ]; then
  echo "Updating macos settings..."
  source ./macos
  sudo reboot
fi

# install brew
read -p "Install Homebrew (y/N): " homebrew
if [ "$homebrew" = "y" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install brew packages
# https://github.com/Homebrew/homebrew-bundle
echo "Install brew packages..."
brew bundle

# install tmux plugin manager (https://github.com/tmux-plugins/tpm#installation)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install zpretzo (https://github.com/sorin-ionescu/prezto#installation)
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# instal vim-plug (https://github.com/junegunn/vim-plug#neovim)
# don't forget to 'PlugInstall' in neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# set zsh as default shell
echo "Set zsh as default shell..."
chsh -s /bin/zsh

# setup hammerspoon
mkdir ~/.hammerspoon
git clone https://github.com/ashfinal/awesome-hammerspoon.git ~/.hammerspoon

# copy dotfiles
echo "Copy dotfiles..."
cp -fv ./vimrc ~/.vimrc
cp -fv ./ideavimrc ~/.ideavimrc
cp -fv ./profile ~/.profile
cp -fv ./exports ~/.exports
cp -fv ./aliases ~/.aliases
cp -fv ./gitconfig ~/.gitconfig
cp -fv ./gitignore ~/.gitignore
cp -fv ./hammerspoon/config.lua ~/.hammerspoon/private/
cp -fv ./bash_profile ~/.bash_profile
cp -fv ./bashrc ~/.bashrc
cp -fv ./zshrc ~/.zshrc
cp -fv ./zpreztorc ~/.zpreztorc
cp -fv ./tmux.conf ~/.tmux.conf
cp -fv ./fzf.zsh ~/.fzf.zsh
cp -fv ./fzf.bash ~/.fzf.bash
cp -rfv ./config ~/.config


echo "Done. Rebooting..."
sudo reboot
