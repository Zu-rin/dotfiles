function git_currnet_branch {
    local branch_name st branch_status

    branch=""
    
    if [ ! -e ".git" ]; then
        return
    fi
    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    st=$(git status 2> /dev/null)

    if [[ -n $(echo $st | grep "nothing to") ]]; then
        branch_status="%F{green}$branch"
    elif [[ -n $(echo $st | grep "Untracked files") ]]; then
        branch_status="%F{red}$branch?" 
    elif [[ -n $(echo $st | grep "Changes not staged for commit") ]]; then
        branch_status="%F{red}$branch+"
    elif [[ -n $(echo $st | grep "Changes to be commited") ]]; then
        branch_status="%F{yellow}$branch!"
    elif [[ -n $(echo $st | grep "^rebase in progress") ]]; then
        echo "%F{red}$branch !(no branch)%f"
        return
    else
        branch_status="%F{cyan}$branch"
    fi

    echo "$branch_status$branch_name%f"
}

setopt prompt_subst

RPROMPT='`git_currnet_branch`'
    
