#!/bin/bash

# set -e

Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;37m'  # White
NC='\033[0m'        # No Color

tools=(
    nvim
    fd
    fdfind # alias name
    rg
    fzf
    gtags
    gitui # prefer gitui
    lazygit
    lf
    yazi
    trash

    # shell
    tmux
    zsh
    fish
    z
    zinit
    starship

    # lsp
    jedi-language-server
    basedpyright
    clangd
    neocmakelsp
    vim-language-server
    lua-language-server
    bash-language-server

    # formatters
    clang-format
    ruff
    stylua
    shfmt
    prettierd
    fixjson

    # debugger
    lldb
    codelldb
)

check_installed() {
    for cmd in ${tools[*]}; do
        if command -v $cmd >/dev/null 2>&2; then
            echo -e "${Green}[INFO] $cmd"
        else
            echo -e "${Yellow}[WARN] $cmd"
        fi
    done
}

case "$1" in
check)
    check_installed
    ;;
*)
    echo 'do nothing'
    ;;
esac
