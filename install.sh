#!/bin/sh

set -e

. ./commands.sh
# link_file <target> <link-name>: creates a symlink. target is relative to this
#                                 repo. link-name is relative to $HOME
# install_package <package-name>: install a package

install_package \
    fzf \
    git-all \
    jq \
    kakoune \
    pass \
    ranger \
    rsync \
    tig \
    tmux \
    ${NULL}

# configure pulseaudio
grep /etc/pulse/daemon.conf -e '^flat-volumes = no' > /dev/null || \
    sudo sed /etc/pulse/daemon.conf -i -e 's:;\?\s*\(flat-volumes\s*=\s*\)\w\+:\1no:g'

# install fonts
[ -n "$(rsync -ai fonts/ ~/.local/share/fonts/)" ] && fc-cache -f

# user scripts
link_file bin .local/bin

# youtube-dl
youtube_dl_path=~/.local/bin/youtube-dl
if [ ! -f "$youtube_dl_path" ]
then
    echo "Fetching youtube-dl"
    download_file https://yt-dl.org/downloads/latest/youtube-dl "$youtube_dl_path"
    chmod a+x "$youtube_dl_path"
fi

# gnome-terminal
dconf_load /org/gnome/terminal/ gnome-terminal.dconf

# tmux
link_file tmux.conf .tmux.conf

# git
link_file gitconfig .gitconfig
link_file gitignore .gitignore

# ranger
link_file config/ranger .config/ranger

# fish
link_file config/fish .config/fish

# kak
link_file config/kak .config/kak

# gdb
link_file gdbinit.d .gdbinit.d
link_file gdb-dashboard .gdb-dashboard
link_file gdbinit .gdbinit
link_file inputrc .inputrc
link_file tgdbinit .tgdbinit

echo 'Success!'
