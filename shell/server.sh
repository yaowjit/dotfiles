#!/bin/bash

source /etc/profile

# if has command
executable() {
    local cmd=$1
    if command -v $cmd >/dev/null 2>&1; then
        return $(true)
    else
        return $(false)
    fi
}

# example
# $(executable "git") && echo 'has git'
# if $(executable "git"); then
#     echo 'has git'
# fi

# -------------------------------- Alias ----------------------------------------------------------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias vdir="vdir --color=auto"

    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

# some more ls aliases
alias ll="ls -lFh"
alias la="ls -lAFh"
alias l="ls -CF"
alias lsg="ll | grep "
alias lag="la | grep"
# 返回上一级、上两级、上三级目录
alias ..="cd ..; l"
alias ...="cd ../..; l"
alias ....="cd ../../..; l"

# rsync
alias rsync="rsync -av --progress "
alias rsync_mirror="rsync --delete "

alias cls="clear"
[[ -f /usr/bin/batcat ]] && alias cat="batcat"
alias cda="conda activate "
alias cdd="conda deactivate "
alias dea="deactivate"

alias cp="cp -r "
alias rm="rm -i "                            # 使用rm 删除的时候，会有一个确认的提示。
[[ -f /usr/bin/trash ]] && alias rm="trash " # 如果有trash, 用trash覆盖
alias psg="ps -A | grep "

# git
alias gst="git status "
alias ga="git add "
alias gc1="git clone --depth=1 "
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
gpull() {
    echo "pull from origin"
    local current_branch=$(git branch --show-current)
    git pull --autostash --rebase origin $current_branch:$current_branch
}

# ssh
alias ssh-keygen="ssh-keygen -t ed25519 " # ed25519 不需要指定长度
alias ssh-keygen-rsa="ssh-keygen -t rsa -b 4096 "

# -------------------------------- Env ------------------------------------------------------------
# .env file example
# ENV1=value1
# ENV2=value2
loadenv() {
    local envfile=".env"
    [[ $1 ]] && envfile=$1
    if [[ -f $envfile ]]; then
        set -a
        source $envfile
        set +a
    else
        echo "no env file founnd"
    fi
}

add_to_path() {
    local p=$1
    if [[ ! $p ]]; then
        return
    fi

    if [[ ! -d $p ]]; then
        return
    fi

    if [[ ! "$PATH" == *"$p"* ]]; then
        export PATH="$p:$PATH"
    fi
}
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/bin"
[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ] && source "$HOME/anaconda3/etc/profile.d/conda.sh"
[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ] && source "$HOME/miniconda3/etc/profile.d/conda.sh"
# 去除重复内容, 且不排序
export PATH=$(echo $PATH | sed "s/:/\n/g" | uniq | tr -s "\n" ":" | sed "s/:$//g")

function proxyenv() {
    echo "HTTP_PROXY=$HTTP_PROXY"
    echo "HTTPS_PROXY=$HTTPS_PROXY"
    echo "http_proxy=$http_proxy"
    echo "https_proxy=$https_proxy"
    echo "all_proxy=$all_proxy"
}
