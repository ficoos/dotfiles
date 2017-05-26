# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
. /usr/share/git-core/contrib/completion/git-prompt.sh

export PS1='\[\033[38;5;2m\][\t]\[$(tput sgr0)\]\[\033[38;5;15m\] \u@\h \[$(tput sgr0)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[\033[38;5;12m\]$(__git_ps1)\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]'

PATH=$HOME/.bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
alias vim=nvim
source $HOME/.rustup.bash-completion
