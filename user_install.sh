# Make rsa key active for this user
echo 'Setting up RSA key'
mkdir ~/.ssh
cp ~/config-files/rsa/id_rsa.pub ~/.ssh/authorized_keys

# Set up configuration files
echo 'Set up configuration files'
ln -sf ~/config-files/zsh/.zshrc ~/
ln -sf ~/config-files/vim/.vimrc ~/
ln -sf ~/config-files/tmux/.tmux.conf ~/

# Install Vundle
echo 'Installing Vundle for vim'
mkdir -p ~/.vim/plugins
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vundle plugins
echo 'Installing Vundle plugins'
vim +PluginInstall +qall

# Change shell to zsh
chsh -s /bin/zsh
echo 'Changed shell to zsh, reboot to make changes applicable'
