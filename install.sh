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
  # Set package manager to pacman
  PACKAGE_MANAGER="pacman -S --noconfirm"
  # Mirror ranking
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
  sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
  echo "Ranking mirrors, this will take a while so relax and get a coffee."
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
  # Update system
  echo "Updating system"
  pacman -Syu --noconfirm
# Ubuntu/Debian
elif [ -e /usr/bin/apt-get ]; then
  # Set package manager to apt-get
  PACKAGE_MANAGER="apt-get install -y"
  # Update system
  echo "Updating system"
  apt-get update -y
  apt-get upgrade -y
fi

# Install all packages
echo "Installing packages"
for i in $PACKAGES; do
  eval "$PACKAGE_MANAGER $i"
done

# Set up configuration files
echo "Set up configuration files"
ln -sf /home/$USERNAME/config-files/zsh/.zshrc /home/$USERNAME/
ln -sf /home/$USERNAME/config-files/vim/.vimrc /home/$USERNAME/

# Install Vundle
echo "Installing Vundle for vim"
mkdir -p /home/$USERNAME/.vim/plugins
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git /home/$USERNAME/.vim/bundle/Vundle.vim

# Change to user
su $USERNAME

# Install Vundle plugins
echo "Installing Vundle plugins"
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
echo "Changed shell to zsh, reboot to make changes applicable"
