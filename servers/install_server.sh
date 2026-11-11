#!/usr/bin/env bash

description="Install servers based on stable (13/trixie)"
# author: Choops <choopsbd@gmail.com>

set -e

debian_version="trixie"    # /!\ Change this every new stable version
scriptpath="$(dirname "$(realpath "$0")")"


usage() {
    errcode="$1"

    [[ $errcode == 0 ]] && echo "$description"

    echo "Usage:"
    echo "  ./$(basename "$0") [OPTION]"
    echo "  WRN: Must be run as 'root' or using 'sudo'"
    echo "Options:"
    echo "  -h,--help: Print this help"
    echo
}

gen_checklist() {
    checklist=()

    for choice in $@; do
        if [[ $choice == "base" ]]; then
            checklist+=("$choice" "|" "ON")
        else
            checklist+=("$choice" "|" "OFF")
        fi
    done

    for elt in ${checklist[@]}; do
        echo "$elt"
    done
}

apply_config() {
    local my_server="$1"

    cp -rf "$scriptpath/dotfiles/vimrc" /root/.vimrc
}

install_base() {
    # Sources cleanup
    rm -f /etc/apt/sources.list
    cp -f "$scriptpath/../desktop/conf/apt/$debian_version.sources" /etc/apt/sources.list.d/debian.sources

    apt clean -y
    apt autoclean -y

    # System upgrade
    apt update
    apt upgrade -y

    # Prerequisites install
    apt install -y curl vim git openssh-server

    # System cleanup
    apt autoremove --purge -y
}


[[ $2 ]] && echo "ERR: Too many arguments" && usage 1

if [[ $1 =~ ^-(h|-help)$ ]]; then
    usage 0
elif [[ $1 ]]; then
    echo "ERR: Bad argument" && usage 1
fi

# Check users permissions
if [[ $(whoami) != root ]]; then
    echo "ERR: Need higher privileges"
    exit 1
fi

# Check debian version
if [[ $(lsb_release -sc) != $debian_version ]] ; then
    echo "ERR: You're not using debian $debian_version"
    exit 1
fi

# Choose server function to install
srv_list=(
    "base"
    "jellyfin"
    "xwiki"
)

srv_checklist=$(gen_checklist ${srv_list[@]})

my_server=($(whiptail --separate-output --radiolist "Server" \
    $((${#srv_list[@]}+8)) 40 ${#srv_list[@]} \
        ${srv_checklist[@]} 3>&1 1>&2 2>&3))

# Here we go !
install_base

[[ $my_server != "base" ]] && (. "$scriptpath/templates/$my_server.sh")

echo -e "\n\\o/ All done ! Enjoy ! ;)"
