# Setup fzf
# ---------
if [[ ! "$PATH" == */.vim/dein/repos/github.com/junegunn/fzf/bin* ]]; then
  PATH="$PATH:~/.vim/dein/repos/github.com/junegunn/fzf/bin"
fi

source <(fzf --zsh)
