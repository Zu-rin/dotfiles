# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/takakuts/.vim/dein/repos/github.com/junegunn/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/takakuts/.vim/dein/repos/github.com/junegunn/fzf/bin"
fi

source <(fzf --zsh)
