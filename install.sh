#!/bin/sh

set -e

. ./commands.sh
# link_file <target> <link-name>: creates a symlink. target is relative to this
#                                 repo. link-name is relative to $HOME
# install_package <package-name>: install a package
# enable_copr <repo-name>       : enable a copr repository

enable_copr smizrahi/tgt
enable_copr gnumdk/lollypop
enable_copr jkonecny/kakoune

install_package $(cat packages.fedora)

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
dconf_load dconf

# tmux
link_file tmux.conf .tmux.conf

# git
link_file gitconfig .gitconfig
link_file gitignore .gitignore

# fish
link_file config/fish .config/fish

# kak
link_file config/kak .config/kak

# nnn
link_file config/nnn .config/nnn

# inputrc
link_file config/inputrc .config/inputrc

# starship
link_file config/starship.toml .config/starship.toml

# gdb
link_file gdbinit.d .gdbinit.d
link_file gdb-dashboard .gdb-dashboard
link_file gdbinit .gdbinit
link_file tgdbinit .tgdbinit

echo 'Success!'
