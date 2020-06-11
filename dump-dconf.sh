#!/bin/sh

dir=${DIR:-dconf}

declare -a paths=(
    "/org/gnome/terminal/"
    "/org/gnome/desktop/wm/keybindings/"
    "/org/gnome/desktop/peripherals/keyboard/"
    "/org/gnome/settings-daemon/plugins/media-keys/"
    "/org/gnome/desktop/interface/"
)

rm $dir/*

for p in "${paths[@]}"
do
    fname=$dir/${p//\//_}.dconf
    dconf dump "$p" > "$fname"
done
