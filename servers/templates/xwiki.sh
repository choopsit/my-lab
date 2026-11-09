#!/usr/bin/env bash

description="Install xwiki on stable (13/trixie)"
# author: Choops <choopsbd@gmail.com>

set -e

debian_version="trixie"    # /!\ Change this every new stable version
my_scriptpath="$(dirname "$(realpath "$0")")"


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

# Install prerequisites
if ! (dpkg -l | grep -q "^ii  gnupg "); then
    apt update
    apt install -y gnupg
fi

# Add xwiki repo
gpgkey_url="https://repo.xwiki.org/xwiki_team.gpg.key"
wget https://maven.xwiki.org/xwiki-keyring.gpg -O /usr/share/keyrings/xwiki.gpg
chmod 644 /etc/apt/keyrings/xwiki.gpg

cp -f "$my_scriptpath/apt/xwiki.sources" /etc/apt/sources.list.d/

apt update

# Install xwiki
#apt install -y xwiki-tomcat10-mariadb
apt install xwiki-tomcat10-mariadb

read -n 1 -s -r -p "Press any key to continue..."

