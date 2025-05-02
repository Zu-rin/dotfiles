#!/bin/zsh

ln -f -s ~/dotfiles/.zshrc ~/.zshrc
ln -f -s ~/dotfiles/.bashrc ~/.bashrc
ln -f -s ~/dotfiles/.vimrc ~/.vimrc
ln -f -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -f -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -f -s ~/dotfiles/tmux-scripts ~/.tmux/scripts
# ln -s ~/dotfiles/nvim ~/.config/nvim
ln -f -s ~/dotfiles/.sheldon ~/.sheldon
ln -f -s ~/dotfiles/.fzf.zsh ~/.fzf.zsh

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
