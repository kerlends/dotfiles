function rofi-launcher
    set opacity 83
    set width 60
    set padding 200
    set bg_color "#0a0f14"
    set fg_color "#98d1ce"
    set hlfg_color $bg_color
    set font "Fantasque Sans Mono 18"

    rofi -show run \
        -lines 3 \
        -eh 2 \
        -width $width \
        -padding $padding \
        -opacity $opacity \
        -bw $bg_color \
        -bc "$bg_color" \
        -bg "$bg_color" \
        -fg "$fg_color" \
        -hlbg "$bg_color" \
        -hlfg "$hlfg_color" \
        -font $font
end
