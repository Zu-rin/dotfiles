source ~/dotfiles/.zsh/git.zsh

function select-history() {
  BUFFER=$(history -n -r 1 | fzf-tmux -d --reverse --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history
bindkey '^[^?' backward-kill-word
# https://khasegawa.hatenablog.com/entry/2017/08/21/000000 意味わからんキレそう
bindkey -e

plugins=(... docker docker-compose)

autoload -Uz promptinit
autoload -Uz colors; colors
autoload -Uz compinit && compinit

userHost="%B%F{green}%n@MBA%f%b"
currentDir="%B%F{cyan}%~%f%b"
PROMPT="$userHost:$currentDir$ "

alias g="git"
alias ga="git add"
alias gA="git add -A"
alias gc="git commit -m"
alias gs="git switch"
alias gch="git checkout"
alias gss="git status"
alias gb="git branch"
alias gd="git diff"

alias dc="docker compose"
alias k="kubectl"
alias kd="kubectl --dry-run=client -o yaml"

alias python="python3"
alias vi="vim"

alias ll="ls -lah --color=auto"
alias upd="sudo apt update && sudo apt upgrade -y"
alias where="whereis"
alias win="cd /mnt/c/Users/takahiro"

alias k="kubectl"
alias dc="docker compose"

# zstyle ':completion:*:(cd|less|cat):*' matcher 'm:(a-z)=(A-Z)'
zstyle ':completion:*' completer _complete _approximate _prefix
zstyle ':completion:*' menu true select

setopt print_eight_bit
setopt auto_cd
setopt correct
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt EXTENDED_HISTORY
setopt interactivecomments

export HISTFILE=~/.zsh_history
export HISTSIZE=500000
export SAVEHIST=10000000
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LESSCHARSET=utf-8
export LESS=-R
export PAGER=less

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

if which go > /dev/null 2>&1; then
    export PATH="$(go env GOROOT)/bin:$PATH"
    export PATH="$(go env GOPATH)/bin:$PATH"
fi
if which anyenv > /dev/null 2>&1; then
    eval "$(anyenv init -)"
fi
if which pyenv > /dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# eval "$(sheldon source)"
# eval "$(anyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export KUBECONFIG=`find ~/.kube -maxdepth 1 -type f | paste -sd ':' -`
while IFS= read -r _kubeconfig; do
    _env="${${_kubeconfig:t}#config-}"
    _name="k8s-$_env"   # :t は zsh のファイル名修飾子（= basename）
    alias "$_name"="kubectl config use-context kubernetes-admin-$_env@$_name"
done < <(find ~/.kube -maxdepth 1 -type f)
unset _kubeconfig _name _env

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/bin/openssl"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export FZF_CTRL_R_OPTS=""
export FZF_TMUX_OPTS="-p"

[ -f ~/.zshenv ] && source ~/.zshenv
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/takakuts/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
