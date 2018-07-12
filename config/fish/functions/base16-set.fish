function base16-set-vim-colorscheme
    set vimrc_path $HOME/.vimrc
    set vimrc_path_backup $HOME/vimrc

    cp $vimrc_path $vimrc_path_backup

    for line in (cat $vimrc_path)
        set new_line $line

        if test (echo $line | grep colorscheme)
            set new_line "colorscheme $argv[1]"
        end

        if test -z $vimrc_str
            set vimrc_str $new_line
        else
            set vimrc_str "$vimrc_str\n$new_line"
        end
    end

    echo -e $vimrc_str > $vimrc_path
end

function base16-set-xresources
    set xresources_path $HOME/.Xresources
    set theme_xresources "$HOME/.config/base16-xresources/xresources/$argv[1]-256.Xresources"
    cp $theme_xresources $xresources_path
    xrdb -load $xresources_path > /dev/null
end

function base16-set-fish-eval
    set theme_name $argv[1]
    echo $theme_name > $FISH_DIR/.base16-theme
    eval sh $HOME/.config/base16-shell/scripts/$theme_name.sh
end

function base16-set
    set theme_prefix "base16"
    set theme_name $argv[1]
    set theme "$theme_prefix-$theme_name"

    set theme_not_found_msg "base16 theme with name '$theme_name' not found."

    if test -z (ls $HOME/.config/base16-shell/scripts | grep $theme)
        echo "$theme_not_found_msg [fish]"
        return
    end

    if test -z (ls $HOME/.config/base16-xresources/xresources | grep $theme)
        echo "$theme_not_found_msg [Xresources]"
        return
    end

    base16-set-vim-colorscheme $theme
    base16-set-xresources $theme
    base16-set-fish-eval $theme
end

