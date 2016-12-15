#!/bin/bash

# Change to root user
[ `whoami` = root ] || exec su -c $0 root

USERNAME="vidr"
PACKAGES="vim zsh htop python3 python2 gnome"

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
  # Update system
  echo "Updating system"
  pacman -Syu --noconfirm
  if [ -e /etc/pacman.d/mirrorlist.pacnew ]; then
    mv -f /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
  fi
  # Mirror ranking
  read -p 'Rank mirrors? (y/N) ' -n 1 -r
  while [[ $REPLY != ^(y|Y|n|N)$ ]]
    do
      cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
      sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
      echo "Ranking mirrors, this will take a while so relax and get a coffee."
      rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
    done
# Ubuntu/Debian
elif [ -e /usr/bin/apt-get ]; then
  # Set package manager to apt-get
  PACKAGE_MANAGER="apt-get install -y"
  # Update system
  echo "Updating system"
  apt-get update -y
  apt-get upgrade -y
fi

# Set time zone
ln -s /usr/share/zoneinfo/Iceland /etc/localtime

# Set locale
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'nb_no.UTF-8 UTF-8' >> /etc/locale.gen
echo 'is_IS.UTF-8 UTF-8' >> /etc/locale.gen

# Set hostname
read -p 'What should the hostname be? ' myhostname
if [ -ne /etc/hostname ]; then
  touch /etc/hostname
fi
echo myhostname > /etc/hostname
echo '127.0.0.1       ' + myhostname + '.localdomain ' + myhostname >> /etc/hosts

# Install all packages
echo "Installing packages"
for i in $PACKAGES; do
  eval "$PACKAGE_MANAGER $i"
done

# Change to user
echo "Changing to $USERNAME"
exec su -c /home/$USERNAME/config-files/user_install.sh $USERNAME
