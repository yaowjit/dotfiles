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

get_latest_tag() {
    repo=$1 # user/repo
    ver_tag=$(curl "https://api.github.com/repos/$repo/tags" | jq -r '.[0].name')
}

get_server_cli_tools() {
    mkdir -p bin/
    rm -rf tmp/ && mkdir -p tmp/
    arch=$(uname -m) # x86_64 aarch64
    case "$arch" in
    x86_64)
        arch2=amd64
        ;;
    aarch64)
        arch2=arm64
        ;;
    *) ;;
    esac

    repo="neovim/neovim"
    get_latest_tag "$repo"
    if [[ $arch == "x86_64" ]]; then
        url="https://github.com/$repo/releases/download/$ver_tag/nvim-linux-$arch.appimage"
    elif [[ $arch == "aarch64" ]]; then
        url="https://github.com/$repo/releases/download/$ver_tag/nvim-linux-$arch2.appimage"
    fi
    wget $url -O bin/nvim
    chmod +x bin/nvim

    repo="sharkdp/fd"
    get_latest_tag "$repo"
    url="https://github.com/$repo/releases/download/$ver_tag/fd-$ver_tag-$arch-unknown-linux-musl.tar.gz"
    wget $url -O tmp/fd.tar.gz
    tar -xf tmp/fd.tar.gz -C tmp/
    cp "tmp/fd-$ver_tag-$arch-unknown-linux-musl/fd" bin/

    repo="BurntSushi/ripgrep"
    ver_tag="14.1.1"
    url="https://github.com/$repo/releases/download/$ver_tag/ripgrep-$ver_tag-$arch-unknown-linux-musl.tar.gz"
    wget $url -O tmp/ripgrep.tar.gz
    tar -xf tmp/ripgrep.tar.gz -C tmp/
    cp "tmp/ripgrep-$ver_tag-$arch-unknown-linux-musl/rg" bin/

    repo="junegunn/fzf"
    get_latest_tag "$repo"
    url=https://github.com/$repo/releases/download/$ver_tag/fzf-${ver_tag:1}-linux_$arch2.tar.gz
    wget $url -O tmp/fzf.tar.gz
    tar -xf tmp/fzf.tar.gz -C bin/

    get_latest_tag "sxyazi/yazi"
    url=https://github.com/$repo/releases/download/$ver_tag/yazi-$arch-unknown-linux-musl.zip
    wget $url -O tmp/yazi.zip
    unzip tmp/yazi.zip -d tmp/
    cp tmp/yazi-$arch-unknown-linux-musl/yazi tmp/yazi-$arch-unknown-linux-musl/ya -t bin/

    get_latest_tag "gitui-org/gitui"
    url=https://github.com/$repo/releases/download/$ver_tag/gitui-linux-$arch.tar.gz
    wget $url -O tmp/gitui.tar.gz
    tar -xf tmp/gitui.tar.gz -C bin/

    rm -rf tmp/
}

case "$1" in
check)
    check_installed
    ;;
server)
    get_server_cli_tools
    ;;
*)
    echo 'do nothing'
    ;;
esac
