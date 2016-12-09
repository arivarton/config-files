#!/bin/bash

USERNAME="vidr"
PACKAGES="zsh htop python3"

# Set up user and sudo rights
ln -sf /home/$USERNAME/config-files/sudo/sudoers /etc/sudoers
useradd -m $USERNAME
echo "Password for $USERNAME"
passwd $USERNAME
groupadd sudo
usermod -G sudo -a $USERNAME
mv ~/config-files/ /home/$USERNAME/
chown 440 /home/$USERNAME/config-files/sudo/sudoers
chown -R $USERNAME:$USERNAME /home/$USERNAME/config-files
cd /home/$USERNAME
su $USERNAME

# Arch Linux
if [ -e /bin/pacman ]; then
  PACKAGE_MANAGER="pacman -S"
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
  sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
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
