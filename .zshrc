source ~/dotfiles/.zsh/git.zsh

plugins=(... docker docker-compose)

autoload -Uz promptinit
autoload -Uz colors; colors
autoload -Uz compinit && compinit

userHost="%B%F{green}%n@wsl%f%b"
currentDir="%B%F{blue}%~%f%b"
PROMPT="$userHost:$currentDir$ "

alias g="git"
alias ga="git add"
alias gA="git add -A"
alias gc="git commit -m"
alias gs="git status"
alias gch="git checkout"
alias gb="git branch"
alias gd="git diff"

alias dc="docker-compose"
alias k="kubectl"

alias python="python3"
alias vi="nvim"

alias ll="ls -lah --color=auto"
alias upd="sudo apt update && sudo apt upgrade -y"
alias win="cd /mnt/c/Users/takahiro"
alias jj="cd ~/project-jj/tech_blog/backend-go"

alias k="kubectl"
alias dc="docker compose"

# zstyle ':completion:*:(cd|less|cat):*' matcher 'm:(a-z)=(A-Z)'
zstyle ':completion:*' completer _complete _approximate _prefix
zstyle ':completion:*' menu true select

setopt print_eight_bit
setopt auto_cd
setopt correct
setopt hist_ignore_dups
setopt interactivecomments

export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"

eval "$(sheldon source)"
eval "$(anyenv init -)"
eval "$(pyenv virtualenv-init -)"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/bin/openssl"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
