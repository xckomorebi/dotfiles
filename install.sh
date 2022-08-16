#! /bin/bash

BASEDIR=$(dirname "$0")

# install ohmyzsh 
if [ "${ZSH}x" = "x" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# copy .zshrc
if [ ! -e "${HOME}/.zshrc"]; then
    ln -s ${BASEDIR}/.zshrc ${HOME}/.zshrc
fi

# vim-plug
if [ ! -e "${HOME}/.vim/autoload" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vimrc && coc.vim
if [ ! -e "${HOME}/.vimrc" ]; then
    ln -s ${BASEDIR}/.vimrc ${HOME}/.vimrc
    vim -c ":PlugInstall"
    ln -s ${BASEDIR}/coc.vim ${HOME}/.vim/coc.vim
fi

# nvim
if [ ! -e "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
    ln -s ${BASEDIR}/.vimrc ${HOME}/.config/nvim/init.vim
    ln -s ${HOME}/.vim/autoload/ ${HOME}/.config/nvim/autoload/
    ln -s ${HOME}/.vim/plugged/ ${HOME}/.config/nvim/plugged/
fi

# tmux
if [ ! -e "${HOME}/.tmux.conf" ]; then
    ln -s ${BASEDIR}/.tmux.conf ${HOME}/.tmux.conf
fi

if [ ! -e "${HOME}/.config/tmux" ]; then
    mkdir -p ${HOME}/.config/tmux
fi

# tmuxline theme
if [ ! -e "${HOME}/.config/tmux/lightline_theme" ]; then
    cp ${BASEDIR}/lightline_theme ${HOME}/.config/tmux/lightline_theme
fi
