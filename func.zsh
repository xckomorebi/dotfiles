# proxy
function setup_clash() {
    export NO_PROXY="localhost,gitlab.infini-ai.com"
    export HTTP_PROXY="http://localhost:7897"
    export HTTPS_PROXY="http://localhost:7897"
    export http_proxy="http://localhost:7897"
    export https_proxy="http://localhost:7897"
    export ALL_PROXY="http://localhost:7897"
}

function unset_proxy() {
    unset NO_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy
    unset ALL_PROXY
}

# setup proxy in alacritty
[[ "$ALACRITTY_WINDOW_ID"x != x ]] && setup_clash

# reset dynamic wall paper
function reset_dw() {
    pkill Dynamic\ Wallpaper
    sleep 1
    open -a Dynamic\ Wallpaper
}

# work
export ENV=ci

function update_conf_path() {
    export CONF_PATH=$(pwd)/config
}

autoload -U add-zsh-hook
add-zsh-hook chpwd update_conf_path
update_conf_path

function init_go_project() {
    SCRIPT_DIR=~/repo/dotfiles

    cp $SCRIPT_DIR/go_projects.mk $(pwd)/Makefile

    cat << EOF >> $(pwd)/.git/info/exclude

*.bak
*.xc.yml
coverage.txt
coverage.xml
coverage.html
Makefile
dockerfile.xc
.cursor
EOF
}

function ala() {
    alacritty --working-directory=$(pwd)
}
