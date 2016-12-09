#!/bin/bash

# Change to root user
[ `whoami` = root ] || exec su -c $0 root

USERNAME="vidr"
PACKAGES="vim zsh htop python3"

# Set up user and sudo rights
useradd -m $USERNAME
mv ~/config-files/ /home/$USERNAME/config-files/
cp /home/$USERNAME/config-files/sudo/sudoers /etc/sudoers
chown root:root /etc/sudoers
chmod 440 /etc/sudoers

# Set password for new user
echo "Password for $USERNAME"
passwd $USERNAME

groupadd sudo
usermod -G sudo -a $USERNAME
chown -R $USERNAME:$USERNAME /home/$USERNAME/config-files

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

# Change to user
echo "Changing to $USERNAME"
exec su -c /home/$USERNAME/config-files/user_install.sh $USERNAME
