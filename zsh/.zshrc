OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    source /Users/hentaitang/.config/broot/launcher/bash/br
elif [[ "$OS" == "Linux" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

ZSH_THEME="robbyrussell"
HIST_STAMPS="mm/dd/yyyy"
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg_bold[red]%}➜ %{$fg[cyan]%}%c%{$fg_bold[blue]%}\$(git_prompt_info)%{$reset_color%} $ "
ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

alias python="python3"
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

mkcd () {
  if [ -n "$1" ]; then
    mkdir -p "$1" && cd "$1"
  else
    echo "Usage: mkcd <directory>"
  fi
}
compdef _directories mkcd
