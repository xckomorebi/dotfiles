if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="${HOME}/.oh-my-zsh"
export EDITOR="nvim"

ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`

HIST_STAMPS="mm/dd/yyyy"

plugins=(tmux git docker brew mvn golang)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

export BC_ENV_ARGS="${HOME}/.bc"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias act='source venv/bin/activate'

if [ -x "$(command -v yt-dlp)" ]; then
    alias youtube-dl="yt-dlp"
fi

if [ -x "$(command -v fzf)" ]; then
    source <(fzf --zsh)
fi

if [ -x "$(command -v nvim)" ]; then
    alias vim=nvim
fi

if [ -e "${HOME}/.zshrc_local" ]; then
    source "${HOME}/.zshrc_local"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /Users/xuchen/.docker/init-zsh.sh || true # Added by Docker Desktop

function update_conf_path() {
    export CONF_PATH=$(pwd)/config
}
autoload -U add-zsh-hook
add-zsh-hook chpwd update_conf_path
update_conf_path
