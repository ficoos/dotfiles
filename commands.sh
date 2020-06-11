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

function enable_copr() {
    dnf copr list | grep "/$1\$" &> /dev/null || sudo dnf copr -y enable "$1"
}

function dconf_load() {
    for f in $1/*
    do
        p=${f##$1/}
        p=${p%%.dconf}
        p=${p//_/\/}
        # we ask the user to validate the change because dconf entries are not
        # linked we might accidentally override a change we want to persist
        dconf dump "$p" | diff --color=auto - "$f" && continue
        while true
        do
            read -r -p "Would you like to override dconf:/$p (Y/n)? " ans
            case "$ans" in
                ""|y)
                    dconf load "$p" < "$f"
                    break
                ;;
                n)
                    echo "Skipping update of dconf:/$p"
                    break
                ;;
                *)
                    echo "Invalid answer"
                ;;
            esac
        done
    done
}

function download_file() {
    url="$1"
    local_path="$2"
    curl -L "$1" -o "$local_path"
}

