# zsh
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`

HIST_STAMPS="mm/dd/yyyy"

plugins=(tmux git docker brew golang)

source $ZSH/oh-my-zsh.sh

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

export HOMEBREW_NO_AUTO_UPDATE=1

# fzf
if [ -x "$(command -v fzf)" ]; then
    source <(fzf --zsh)
fi

# nvim
if [ -x "$(command -v nvim)" ]; then
    alias vim=nvim
    export EDITOR="nvim"
    export MANPAGER="nvim +Man!"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ -e "${HOME}/.zshrc_local" ]; then
    source "${HOME}/.zshrc_local"
fi

ZSH_CONFIG_DIR="${XDG_CACHE_HOME:-$HOME/.config}/zsh"
for config_file in $ZSH_CONFIG_DIR/*.zsh; do
    [[ -f "$config_file" ]] && source "$config_file"
done

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

