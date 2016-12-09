#!/bin/bash

USERNAME="vidr"
PACKAGES="vim zsh htop python3"

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
  PACKAGE_MANAGER="pacman -S --noconfirm"
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
  sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
  pacman -Syu
# Ubuntu/Debian
elif [ -e /usr/bin/apt-get ]; then
  PACKAGE_MANAGER="apt-get install -y"
  apt-get update
  apt-get upgrade
fi

# Install all packages
for i in $PACKAGES; do
  eval "$PACKAGE_MANAGER $i"
done

# Set up configuration files
ln -sf /home/$USERNAME/config-files/zsh/.zshrc /home/$USERNAME/
ln -sf /home/$USERNAME/config-files/vim/.vimrc /home/$USERNAME/

# Install Vundle
mkdir -p /home/$USERNAME/.vim/plugins
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git /home/$USERNAME/.vim/bundle/Vundle.vim

# Change to user
su $USERNAME

# Install Vundle plugins
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
