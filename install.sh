#!/bin/bash

USERNAME="vidr"
PACKAGES="zsh htop python3"

# Set up user and sudo rights
ln -sf ~/config-files/sudo/sudoers /etc/sudoers
chmod 440 /etc/sudoers
useradd -m $USERNAME
passwd $USERNAME
groupadd sudo
usermod -G sudo -a $USERNAME
mv ~/config-files/ /home/$USERNAME/
chown $USERNAME:$USERNAME /home/$USERNAME/config-files
su $USERNAME

cd ~

# Arch Linux
if [ -e /bin/pacman ]; then
  PACKAGE_MANAGER="pacman -S"
  sudo pacman -Syu
# Ubuntu/Debian
elif [ -e /usr/bin/apt-get ]; then
  PACKAGE_MANAGER="apt-get install"
  sudo apt-get update
  sudo apt-get upgrade
fi

for i in $PACKAGES; do
  eval "sudo $PACKAGE_MANAGER $i"
done

# Set up configuration files
ln -sf ~/config-files/zsh/.zshrc ~/
ln -sf ~/config-files/vim/.vimrc ~/

# Install Vundle
mkdir -p ~/.vim/plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
