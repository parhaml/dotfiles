#!/bin/sh

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

echo "Y" | sudo apt purge neovim
sudo apt install vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
rm -rf $HOME/.vimrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/vimrc ~/.vimrc

