# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/smizrahi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
bindkey "^R" history-incremental-search-backward
setopt HIST_IGNORE_DUPS
setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select

alias vim=nvim # prefer neovim
# git status in prompt
export PATH=$HOME/.bin:$PATH # Add local bin
export PATH="$HOME/.cargo/bin:$PATH" # Add rust bin

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} %*"
    zle reset-prompt
}

# Delete and backspace
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line
bindkey '^?' backward-delete-char      # [Backspace] - delete backward

# Set up prompt
autoload -Uz promptinit
promptinit
autoload -Uz colors && colors
zle -N zle-line-init
zle -N zle-keymap-select
setopt PROMPT_SUBST
source /usr/share/git-core/contrib/completion/git-prompt.sh

PROMPT='[%n@%m %.%b$(__git_ps1 " (%s)")]%# '
RPROMPT='%t'
