#!/bin/zsh

ln -f -s ~/dotfiles/.zshrc ~/.zshrc
ln -f -s ~/dotfiles/.bashrc ~/.bashrc
ln -f -s ~/dotfiles/.vimrc ~/.vimrc
ln -f -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -f -s ~/dotfiles/.tmux.conf ~/.tmux.conf
# 既にリンクがあると ln -sf はリンク先のディレクトリの中に新しいリンクを作ってしまうため、-n でリンク自体を置き換える
ln -sfn ~/dotfiles/tmux-scripts ~/.tmux/scripts
# ln -s ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/.sheldon ~/.sheldon
ln -f -s ~/dotfiles/.fzf.zsh ~/.fzf.zsh

# Claude Code: ~/.claude には認証情報や会話の履歴も置かれるため、
# ディレクトリ全体ではなく自分で書いた設定だけを個別にリンクする
mkdir -p ~/.claude/skills
for target in CLAUDE.md settings.json hooks scripts skills/compact-prep; do
  # 実体のファイルやディレクトリが既にあると、ln -sfn では置き換わらず中にリンクが作られるため退避する
  if [ -e ~/.claude/$target ] && [ ! -L ~/.claude/$target ]; then
    mv ~/.claude/$target ~/.claude/$target.bak.$(date +%Y%m%d%H%M%S)
  fi
  ln -sfn ~/dotfiles/claude/$target ~/.claude/$target
done

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 1. `<Prefix> I` on tmux
# 2. `vim` to install vim plugins
# 3. `.vim/dein/repos/github.com/junegunn/fzf/install` to install fzf
