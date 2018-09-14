#!/usr/bin/env bash

distro=$( uname -r | sed 's/[0-9\.-]//g' )
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

s1=$script_dir
h1=$HOME
config_dir=$h1/.config
    

copy_files() {
    i3_dir=$config_dir/i3
    vimrc=$h1/.vimrc
    xresources=$h1/.Xresources
    xdefaults=$h1/.Xdefaults
    xinitrc=$h1/.xinitrc

    cp -brf $s1/config/fish/* $config_dir/fish/

    if ! test -d $i3_dir; then
        cp -rf $s1/config/i3 $config_dir/i3
    fi


    cp -b $s1/vimrc $vimrc

    cp -b $s1/Xresources $xresources
    cp -b $s1/Xdefaults $xdefaults
    cp -b $s1/xinitrc $xinitrc
}

install_yaourt() {
    if command -v yaourt >/dev/null 2>&1; then
        echo "yaourt already installed"
        return
    fi

    AUR=https://aur.archlinux.org

    pkgq=$s1/pkg-query
    yaourt=$s1/yaourt

    git clone $AUR/package-query.git $pkgq
    cd $pkgq
    makepkg -si --noconfirm

    git clone $AUR/yaourt.git $yaourt
    cd $yaourt
    makepkg -si --noconfirm

    cd $s1

    rm -rf $pkgq $yaourt
}

install_nvm() {
    nvm_dir=$h1/.nvm

    if ! test -d $nvm_dir; then
        version=v0.33.11
        url=https://raw.githubusercontent.com/creationix/nvm/$version/install.sh

        NVM_DIR=$nvm_dir curl -o- $url | bash
    fi
}

install_fisherman() {
    if ! command -v fish >/dev/null 2>&1; then
        echo "fish shell is not installed"
        return
    fi

    url=https://git.io/fisher
    fish_dir=$config_dir/fish
    install_path=$fish_dir/functions/fisher.fish 

    if ! test -e $install_path; then
        curl -Lo $install_path --create-dirs $url
        fish -c "fisher install"
    fi
}

install_vim_plug() {
    if ! command -v vim >/dev/null 2>&1; then
        echo "vim is not installed"
        return
    fi

    url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    install_path=$h1/.vim/autoload/plug.vim

    if ! test -e $install_path; then
        curl -fLo $install_path --create-dirs $url
    fi

    vim +PlugInstall +qa
}

install_base16() {
    url_x=https://github.com/chriskempson/base16-xresources
    url_shell=https://github.com/chriskempson/base16-shell
    b16_xresources_dir=$config_dir/base16-xresources
    b16_shell_dir=$config_dir/base16-shell

    if ! test -d $b16_xresources_dir; then
        git clone $url_x $b16_xresources_dir
    fi

    if ! test -d $b16_shell_dir; then
        git clone $url_shell $b16_shell_dir
    fi
}

prepare_dirs() {
    local_bin_dir=$h1/.local/bin
    proj_dir=$h1/projects
    repo_dir=$h1/repositories

    if ! test -d $local_bin_dir; then
        mkdir -p $local_bin_dir
    fi

    if ! test -d $proj_dir; then
        mkdir $proj_dir
    fi

    if ! test -d $repo_dir; then
        mkdir $repo_dir
    fi
}

setup_shell_theme() {
    shell_theme_default=base16-railscasts
    shell_theme_path=$config_dir/fish/.base16-theme

    if test -d $shell_theme_path; then
        if test -z $(cat $shell_theme_path); then
            echo $shell_theme_default > $shell_theme_path
        fi;
    else
        echo $shell_theme_default > $shell_theme_path
    fi
}

setup_packages() {
    sudo pacman -Syuq
    cat $s1/native-packages | xargs sudo pacman -Sq --needed --noconfirm
    install_yaourt
    cat $s1/aur-packages | xargs yaourt -Sq --needed --noconfirm
}


bootstrap() {
    setup_packages

    prepare_dirs

    copy_files

    setup_shell_theme

    install_nvm
    install_vim_plug
    install_base16
    install_fisherman
}

bootstrap
