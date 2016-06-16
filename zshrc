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
source /usr/share/git-core/contrib/completion/git-prompt.sh
setopt PROMPT_SUBST
PROMPT='[%n@%m %.%b$(__git_ps1 " (%s)")]%# '
export PATH=$HOME/.bin:$PATH # Add local bin
export PATH="$HOME/.cargo/bin:$PATH" # Add rust bin

