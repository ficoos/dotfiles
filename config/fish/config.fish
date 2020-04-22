set -l fish_config_path "$HOME/.config/fish"

# Additional PATH
set --export PATH $PATH $HOME/.local/bin
set --export PATH "$HOME/.cargo/bin" $PATH
set --export PATH "$HOME/go/bin" $PATH

set --export TERMINAL "terminal"

# pass
set --export PASSWORD_STORE_ENABLE_EXTENSIONS true

# ansible
set --export ANSIBLE_NOCOWS 1

# preferences
if [ -z "$EDITOR" ]
    set --export EDITOR kak --
end

bind ctrl+t to fzf-file-widget
# bind ctrl+r to fzf-history-widget
# bind alt+c fzf-cd-widget
source $fish_config_path/fzf.fish
fzf_key_bindings

function has_command
    which $argv 2> /dev/null > /dev/null
end

function hg_branch
    has_command hg; and hg branch ^ /dev/null | awk '{print $1}'
end

function __scm_prompt
    set gitps (__fish_git_prompt | string trim -c '() ')
    set hgps (hg_branch)
    if [ -n "$gitps" ]
        echo " (git:$gitps)";
    else if [ -n "$hgps" ]
        echo " (hg:$hgps)"
    else
        echo ""
    end
end

function fish_prompt
    echo -e "\033[32m["(date +%T)"]\033[0m "(whoami)"\033[38;5;8m@\033[38;5;7m"(hostname) "\033[36m"(pwd | string replace -r "^$HOME" '~')"\033[35m"(__scm_prompt)"\033[0m\n\$ "(tput sgr0)
end

function fish_greeting
    has_command fortune cowsay; and fortune | cowsay
end

function r
    set tempfile (mktemp -t tmp.XXXXXX)
    command ranger --choosedir=$tempfile $argv
    if test -s $tempfile
        set ranger_pwd (cat $tempfile)
        if test -n $ranger_pwd -a -d $ranger_pwd
            builtin cd -- $ranger_pwd
        end
    end

    command rm -f -- $tempfile
end

function vim
    if [ "$NVIM_LISTEN_ADDRESS" = "" ]
        nvim $argv
    else
        nvr $argv
    end
end

function pfzf
    pass fzf $argv
end

function tkak
    set session_name (basename $PWD)
    tmux new kak $argv \; rename-session "$session_name"
end

function nav
    set filter -maxdepth 1 -type d
    if [ "$argv[1]" != "-a" ]
        set -a filter -name '[^.]*'
    end
    set dir (begin; echo -e ".."; find $filter; end | fzf --no-multi --prompt "$PWD/" --height 10)
    [ $status -eq 0 ] && cd "$dir" && nav $argv
end
