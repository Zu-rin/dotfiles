function git_currnet_branch {
    local out line head="" untracked=0 unstaged=0 staged=0

    # ブランチ名とファイルの状態を1回の git の実行でまとめて取る
    # (リポジトリの外、.git ディレクトリの中、bare リポジトリでは失敗するので何も表示しない)
    out=$(git status --porcelain=v2 --branch 2> /dev/null) || return

    # 各行の意味:
    #   "# branch.head <name>"  現在のブランチ名 (HEAD が切り離されていると "(detached)")
    #   "? <path>"              未追跡のファイル
    #   "1 XY ..." / "2 XY ..." 変更されたファイル / 名前が変わったファイル
    #   "u XY ..."              コンフリクト中のファイル
    # XY の X はステージの状態、Y は作業ツリーの状態で、変更がないと "." になる
    for line in "${(@f)out}"; do
        case $line in
            '# branch.head '*)
                head=${line#'# branch.head '}
                ;;
            '? '*)
                untracked=1
                ;;
            [12u]' '*)
                [[ ${line[3]} != "." ]] && staged=1
                [[ ${line[4]} != "." ]] && unstaged=1
                ;;
        esac
    done

    if [[ $head == "(detached)" ]]; then
        # rebase 中は HEAD が切り離され、.git の下に rebase-merge か rebase-apply ができる
        # (HEAD が切り離されているときだけ確かめるので、普段は git を1回しか実行しない)
        local git_dir=$(git rev-parse --git-dir 2> /dev/null)
        if [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" ]]; then
            echo "%F{red}!(no branch)%f"
            return
        fi
        head="HEAD"
    fi

    if (( untracked )); then
        echo "%F{red}$head?%f"
    elif (( unstaged )); then
        echo "%F{red}$head+%f"
    elif (( staged )); then
        echo "%F{yellow}$head!%f"
    else
        echo "%F{green}$head%f"
    fi
}

setopt prompt_subst

RPROMPT='`git_currnet_branch`'

# 入力待ちのまま TMOUT 秒が過ぎるたびに TRAPALRM が呼ばれるので、
# そこでプロンプトを描き直して、Enter を押さなくても git の状態を最新にする
TMOUT=2
TRAPALRM() {
    # 補完メニューや fzf の操作中に描き直すと表示が崩れるため、その間は描き直さない
    case "$WIDGET" in
        *complete*|*menu*|select-history|fzf-*) return ;;
    esac
    zle reset-prompt
}
    
