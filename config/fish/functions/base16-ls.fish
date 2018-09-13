set -g background_color "#282828"
set -g theme_name_color "#f7ca88"
set -g count_color "#fff"

function base16-ls
    set -g _bg (set_color -b $background_color)
    set -g _fg (set_color $theme_name_color)
    set -g _fgb (set_color $theme_name_color --bold)
    set -g _cfg (set_color $count_color --bold)
    set -g _clrr (set_color normal)

    set -g theme_list_path $HOME/.config/.b16-themes-list
    set -g theme_list_path_raw $HOME/.config/.b16-themes-list-raw
    set -g colors 1

    if test (count $argv) -ge 2
        for arg in $argv[2..-1]
            if test $arg = '--raw'
                set -g colors 0
            end
        end
    end

    function base16-ls-gen
        set count 1

        for line in (ls $HOME/.config/base16-shell/scripts)
            set full_theme_name (echo $line | sed 's/\.sh//g')
            set b16_theme_name (echo $full_theme_name | sed 's/base16-//')
            set theme_name "$_bg$_cfg$count.$_clrr$_bg $_fg$b16_theme_name $_fgb($full_theme_name)$_clrr"

            echo -e $theme_name

            if test -z $base16_themes
                set base16_themes $theme_name
            else
                set base16_themes "$base16_themes\n$theme_name"
            end
            set count (math "$count+1")
        end

        echo -e $base16_themes > $theme_list_path
    end

    function base16-ls-gen-raw
        set count 1

        for line in (ls $HOME/.config/base16-shell/scripts)
            set full_theme_name (echo $line | sed 's/\.sh//g')
            set b16_theme_name (echo $full_theme_name | sed 's/base16-//')
            set theme_name "$count. $b16_theme_name ($full_theme_name)"

            if test -z $base16_themes
                set base16_themes $theme_name
            else
                set base16_themes "$base16_themes\n$theme_name"
            end
            set count (math "$count+1")
        end

        echo -e $base16_themes > $theme_list_path_raw
    end

    if test $colors -eq 0
        if test ! -f $theme_list_path_raw
            base16-ls-gen-raw
        end

        cat $theme_list_path_raw
    else
        if test ! -f $theme_list_path
            base16-ls-gen
        end
        
        cat $theme_list_path
    end
end
