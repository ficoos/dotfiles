#!/bin/sh

set -e

. ./commands.sh
# link_file <target> <link-name>: creates a symlink. target is relative to this
#                                 repo. link-name is relative to $HOME
# install_package <package-name>: install a package

install_package jq rsync

# configure pulseaudio
grep /etc/pulse/daemon.conf -e '^flat-volumes = no' > /dev/null || \
    sudo sed /etc/pulse/daemon.conf -i -e 's:;\?\s*\(flat-volumes\s*=\s*\)\w\+:\1no:g'

# install fonts
[ -n "$(rsync -ai fonts/ ~/.local/share/fonts/)" ] && fc-cache -f

# user scripts
link_file bin .local/bin

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
