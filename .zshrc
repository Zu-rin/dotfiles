source ~/dotfiles/.zsh/git.zsh

plugins=(... docker docker-compose)

autoload -Uz promptinit
autoload -Uz colors; colors
autoload -Uz compinit && compinit

userHost="%B%F{green}%n@%m%f%b"
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
alias vi="vim"

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

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LESSCHARSET=utf-8
export LESS=-R
export PAGER=less
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"

# eval "$(sheldon source)"
eval "$(anyenv init -)"
eval "$(pyenv init -)"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/bin/openssl"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

source ~/.zshenv