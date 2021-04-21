set -l fish_config_path "$HOME/.config/fish"

# Additional PATH
[ -z "$XDG_CONFIG_HOME" ] && set --export XDG_CONFIG_HOME $HOME/.config
set --export PATH $PATH $HOME/.local/bin
set --export PATH "$HOME/.cargo/bin" $PATH
set --export PATH "$HOME/go/bin" $PATH
set --export INPUTRC "$XDG_CONFIG_HOME/inputrc"

set --export TERMINAL "terminal"

# pass
set --export PASSWORD_STORE_ENABLE_EXTENSIONS true

# ansible
set --export ANSIBLE_NOCOWS 1

# force x11 backend for ssh sessions
[ -n "$SSH_CONNECTION" ]; and set --export GDK_BACKEND x11

# preferences
set --export EDITOR nvim

# bind ctrl+t to fzf-file-widget
# bind ctrl+r to fzf-history-widget
# bind alt+c fzf-cd-widget
source $fish_config_path/fzf.fish
fzf_key_bindings

# nnn
source $fish_config_path/quitcd.fish
set SELF %self
set --export NNN_BMS 'd:~/Documents;c:~/.config;D:~/Downloads;C:~/Comics;m:~/Music'
set --export NNN_PLUG 'r:run'
set --export NNN_TRASH '1'
set --export NNN_SEL "$XDG_CONFIG_HOME/nnn/.selection_$SELF"

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

function fish_greeting
    has_command fortune cowsay; and fortune | cowsay
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

