base_dir=$(readlink -f $(dirname "$0"))

function link_file() {
    target="$base_dir/$1"
    link_name="$HOME/$2"

    [ -L "$link_name" -a "$(readlink -f "$link_name")" == "$target" ] && \
        return 0
    [ -e "$link_name" ] && \
        printf 'ERROR: link "%s" -> "%s", target already exists\n' "$target" "$link_name" && \
        return 1
    ln -s "$target" "$link_name"
    printf 'LINK: "%s" -> "%s"\n' "$target" "$link_name"
}

function install_package() {
    rpm -q "$@" 2>&1 | grep "is not installed" | cut -d ' ' -f 2 | \
        xargs -r sudo dnf install -y
}

function dconf_load() {
    dconf load "$1" < "$2"
}
