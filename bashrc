# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
. /usr/share/git-core/contrib/completion/git-prompt.sh

function draw_sep {
	cols=$(tput cols)
	printf "%0.s─" $(eval "echo {1.."$(($cols))"}")
	printf "\n"
}

function hg_branch() {
	hg branch 2> /dev/null | awk '{print $1}'
}

function __scm_ps1 {
	gitps=$(__git_ps1)
	hgps=$(hg_branch)
	if [ -n "$gitps" ]; then
		echo " (git:${gitps:2}";
	elif [ -n "$hgps" ]; then
		echo " (hg:$hgps)"
	fi;
}
#\[\033[0;37m\]$(draw_sep)\[\033[0m\]
export PS1='\[\033[38;5;2m\][\t]\[$(tput sgr0)\]\[\033[38;5;15m\] \u@\h \[$(tput sgr0)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[\033[38;5;12m\]$(__scm_ps1)\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]'

PATH=$HOME/.bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
alias vim=nvim
source $HOME/.rustup.bash-completion
export RUST_SRC_PATH=$HOME/.rustup/toolchains/$(rustup toolchain list | grep default | awk {'print $1'})/lib/rustlib/src/rust/src/
