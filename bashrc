# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
. /usr/share/git-core/contrib/completion/git-prompt.sh

export PS1='[\u@\h \W$(__git_ps1)]\$ '

PATH=$HOME/.bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
alias vim=nvim
source $HOME/.rustup.bash-completion

if [ "$PS1" ]; then
    case $TERM in
    xterm*|vte*)
      if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
          PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
      elif [ "${VTE_VERSION:-0}" -ge 3405 ]; then
          PROMPT_COMMAND="__vte_prompt_command"
      else
          PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
      fi
      ;;
    screen*)
	    PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "$(basename ${PWD/#$HOME/\~})"'
      ;;
    *)
            PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"'
      ;;
    esac
fi
