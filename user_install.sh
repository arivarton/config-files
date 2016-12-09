# Make rsa key active for this user
echo "Setting up RSA key"
mkdir ~/.ssh
cp ~/config-files/rsa/id_rsa.pub ~/.ssh/authorized_keys

# Set up configuration files
echo "Set up configuration files"
ln -sf /home/$USERNAME/config-files/zsh/.zshrc /home/$USERNAME/
ln -sf /home/$USERNAME/config-files/vim/.vimrc /home/$USERNAME/

# Install Vundle
echo "Installing Vundle for vim"
mkdir -p /home/$USERNAME/.vim/plugins
git clone https://github.com/VundleVim/Vundle.vim.git /home/$USERNAME/.vim/bundle/Vundle.vim
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vim

# Install Vundle plugins
echo "Installing Vundle plugins"
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
echo "Changed shell to zsh, reboot to make changes applicable"
