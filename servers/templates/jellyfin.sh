#!/usr/bin/env bash

description="Install jellyfin on stable (13/trixie)"
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

# Add jellyfin repo
gpgkey_url="https://repo.jellyfin.org/jellyfin_team.gpg.key"
wget -O- $gpgkey_url | gpg --dearmor --yes --output /usr/share/keyrings/jellyfin.gpg
chmod 644 /usr/share/keyrings/jellyfin.gpg

cp -f "$my_scriptpath/apt/jellyfin.sources" /etc/apt/sources.list.d/

apt update

# Install jellyfin
apt install -y jellyfin

chown -R jellyfin:adm /etc/jellyfin

echo "> Waiting 15 seconds for Jellyfin to fully start up."
sleep 15
echo

# Validate Jellyfin is running
echo "-------------------------------------------------------------------------------"
systemctl status jellyfin.service
echo "-------------------------------------------------------------------------------"
echo

# Determine the IP address of the interface which contains the default gateway
# This is a relatively sure bet to be the IP address that Jellyfin can be accessed on, for later display
gateway_iface="$( ip route \
                  | grep '^default' \
                  | head -1 \
                  | grep -o 'dev [a-z0-9]* ' \
                  | awk '{ print $NF }' )"
ipaddress="$( ip address show dev "$gateway_iface" \
               | grep -w "inet .* $gateway_iface$" \
               | awk '{ print $2 }' \
               | awk -F '/' '{ print $1 }' )"

echo "If service is running, then you can access your new instance now at http://${ipaddress}:8096 in your web browser to finish setting up Jellyfin."
echo

read -n 1 -s -r -p "Press any key to continue..."

