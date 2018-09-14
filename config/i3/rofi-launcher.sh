#!/bin/bash

PATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH

opacity=83

width=60

padding=200

bg_color="#0a0f14"

fg_color="#98d1ce"

hlfg_color=$bg_color

font="Fantasque Sans Mono 18"

run_prefix=">> "

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
    -hlfg "$bg_color" \
    -font "$font" \
    -display-run "$run_prefix"
