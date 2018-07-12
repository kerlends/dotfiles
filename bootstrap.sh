#!/usr/bin/env bash

distro=$(uname -r | sed 's/[0-9\.-]//g')

install_nvm() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
}

install_fish_ubuntu() {
    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install fish
}

install_fish_arch() {
    echo "Install fish: arch"
}

install_fish_mac() {
    echo "Install fish: mac"
}

install_fish() {
    if [ $distro == 'Ubuntu' ]; then
        install_fish_ubuntu
    elif [ $distro == 'ARCH' ]; then
        install_fish_arch
    elif [ $distro == 'Darwin' ]; then
        install_fish_mac
    else
        echo "$distro is not supported"
    fi
}

bootstrap() {
    install_fish
}

bootstrap
