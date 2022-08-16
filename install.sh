#! /bin/bash

BASEDIR=$(
    cd $(dirname "$0")
    pwd
)

# install ohmyzsh 
if [ "${ZSH}x" = "x" ]; then
    echo "install ohmyzsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "ohmyzsh detected, no need to install"
fi

# copy .zshrc
if [ ! -e "${HOME}/.zshrc" ]; then
    echo "symbolic linking .zshrc"
    ln -s ${BASEDIR}/.zshrc ${HOME}/.zshrc
else
    echo "no need to link .zshrc"
fi

# vim-plug
if [ ! -e "${HOME}/.vim/autoload" ]; then
    echo "installing vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "no need to install vim-plug"
fi

# vimrc && coc.vim
if [ ! -e "${HOME}/.vimrc" ]; then
    echo "symbolic linking vimrc"
    ln -s ${BASEDIR}/.vimrc ${HOME}/.vimrc

    echo "installing vim plugins"
    ln -s ${BASEDIR}/coc.vim ${HOME}/.vim/coc.vim
else
    echo "no need to link .vimrc"
fi

vim -c ":PlugInstall"

# nvim
if [ ! -e "${HOME}/.config/nvim" ]; then
    echo "linking vim settings to nvim"
    mkdir -p "${HOME}/.config/nvim"
    ln -s ${BASEDIR}/.vimrc ${HOME}/.config/nvim/init.vim
    ln -s ${HOME}/.vim/autoload/ ${HOME}/.config/nvim/autoload/
    ln -s ${HOME}/.vim/plugged/ ${HOME}/.config/nvim/plugged/
fi

# tmux
if [ ! -e "${HOME}/.tmux.conf" ]; then
    echo "linking .tmux.conf"
    ln -s ${BASEDIR}/.tmux.conf ${HOME}/.tmux.conf
fi

if [ ! -e "${HOME}/.config/tmux" ]; then
    mkdir -p ${HOME}/.config/tmux
fi

# tmuxline theme
if [ ! -e "${HOME}/.config/tmux/lightline_theme" ]; then
    cp ${BASEDIR}/lightline_theme ${HOME}/.config/tmux/lightline_theme
fi
