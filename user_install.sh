USERNAME='vidr'

# Make rsa key active for this user
echo "Setting up RSA key"
mkdir ~/.ssh
cp /home/$USERNAME/config-files/rsa/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

# Set up configuration files
echo "Set up configuration files"
ln -sf /home/$USERNAME/config-files/zsh/.zshrc /home/$USERNAME/
ln -sf /home/$USERNAME/config-files/vim/.vimrc /home/$USERNAME/

# Install Vundle
echo "Installing Vundle for vim"
mkdir -p /home/$USERNAME/.vim/plugins
mkdir -p /home/$USERNAME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vundle plugins
echo "Installing Vundle plugins"
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
echo "Changed shell to zsh, reboot to make changes applicable"
