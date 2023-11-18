#!/bin/zsh

mkdir -p ~/.config
touch ~/.zsh_history
touch ~/.zshenv

ln -f -s ~/dotfiles/.zshrc ~/.zshrc
ln -f -s ~/dotfiles/.bashrc ~/.bashrc
ln -f -s ~/dotfiles/.vimrc ~/.vimrc
ln -f -s ~/dotfiles/.gitcogfig ~/.gitconfig
ln -f -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -f -s ~/dotfiles/nvim ~/.config/nvim
ln -f -s ~/dotfiles/.sheldon ~/.sheldon
ln -f -s ~/dotfiles/.ssh/config ~/.ssh/config
ln -f -s ~/dotfiles/.ssh/authorized_keys ~/.ssh/authorized_keys
