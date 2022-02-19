autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# completion
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' menu select
zmodload zsh/complist

# options
setopt globdots
setopt autocd

# vi mode
bindkey -v

# PS1
# prompt_zen_setup() { PS1="%K{white}%F{black}%~%f%k %% " }
prompt_zen_setup() { PS1="%~ %% " }
prompt_themes+=( zen )
prompt zen

# $PATH
typeset -U PATH path
path=("$HOME/.local/scripts"
    "$PYENV_ROOT/bin"
    "$path[@]"
)
export PATH

# aliases
alias "vi"="nvim"
alias "vim"="nvim"
alias "ls"="ls -lav --color=always"
alias "youtube-dl-auto"="youtube-dl -f bestvideo+bestaudio"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history

# keybindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
