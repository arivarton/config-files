#!/bin/bash

USERNAME="vidr"
PACKAGES="zsh htop python3"

# Set up user and sudo rights
useradd -m $USERNAME
mv ~/config-files/ /home/$USERNAME/config-files/
cp /home/$USERNAME/config-files/sudo/sudoers /etc/sudoers
chown root:root /etc/sudoers
chmod 440 /etc/sudoers
echo "Password for $USERNAME"
passwd $USERNAME
groupadd sudo
usermod -G sudo -a $USERNAME
chown -R $USERNAME:$USERNAME /home/$USERNAME/config-files
cd /home/$USERNAME

# Arch Linux
if [ -e /bin/pacman ]; then
  PACKAGE_MANAGER="pacman -S"
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
  sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
  pacman -Syu
# Ubuntu/Debian
elif [ -e /usr/bin/apt-get ]; then
  PACKAGE_MANAGER="apt-get install"
  apt-get update
  apt-get upgrade
fi

for i in $PACKAGES; do
  eval "$PACKAGE_MANAGER $i"
done

# Set up configuration files
ln -sf ~/config-files/zsh/.zshrc ~/
ln -sf ~/config-files/vim/.vimrc ~/

# Install Vundle
mkdir -p ~/.vim/plugins
chown -R $USERNAME:$USERNAME ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim
su $USERNAME
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
