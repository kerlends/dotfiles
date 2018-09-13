#!/usr/bin/env bash

distro=$( uname -r | sed 's/[0-9\.-]//g' )
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

s1=$script_dir
h1=$HOME
config_dir=$h1/.config
    

copy_files() {
    cp $s1/config/fish $config_dir/fish
    cp $s1/config/i3 $config_dir/i3

    cp $s1/vimrc $h1/.vimrc

    cp $s1/Xresources $h1/.Xresources
    cp $s1/Xdefaults $h1/.Xdefaults
    cp $s1/xinitrc $h1/.xinitrc
}

install_yaourt() {
    AUR=https://aur.archlinux.org

    pkgq=$s1/pkg-query
    yaourt=$s1/yaourt

    git clone $AUR/package-query.git $pkgq
    git clone $AUR/yaourt.git $yaourt

    cd $pkgq
    makepkg -si

    cd $yaourt
    makepkg -si

    cd $s1

    rm -rf $pkgq $yaourt
}

install_alacritty() {
    url=https://aur.archlinux.org/alacritty-git.git
    tmp_path=$s1/alacritty-git

    git clone $url $tmp_path
    cd $tmp_path
    makepkg -isr
    rm -rf $tmp_path
}

install_nvm() {
    version=v0.33.11
    url=https://raw.githubusercontent.com/creationix/nvm/$version/install.sh

    curl -o- $url | bash
}

install_fisherman() {
    url=https://git.io/fisher
    install_path=$h1/.config/fish/functions/fisher.fish 

    curl -Lo $install_path --create-dirs $url
}

install_vim_plug() {
    url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    install_path=$h1/.vim/autoload/plug.vim

    curl -fLo $install_path --create-dirs $url
}

install_base16() {
    url_x=https://github.com/chriskempson/base16-xresources
    url_shell=https://github.com/chriskempson/base16-shell

    git clone $url_x $config_dir
    git clone $url_shell $config_dir
}

prepare_dirs() {
    mkdir -p $h1/.local/bin
    mkdir $h1/projects
    mkdir $h1/repositories
}

bootstrap() {
    sudo pacman -Syu

    cat ./native-packages | xargs sudo pacman -S --needed
    install_yaourt
    cat ./aur-packages | xargs yaourt -S --needed

    prepare_dirs

    copy_files

    install_alacritty
    install_nvm
    install_vim_plug
    install_fisherman
    install_base16

    fisher install
}

bootstrap
