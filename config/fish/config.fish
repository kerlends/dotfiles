if test (tty) = '/dev/tty1'
    exec startx
end

set -x PATH \
    $HOME/.local/bin \
    $PATH

set -x EDITOR nvim
set -x REACT_EDITOR nvim
set -x FISH_DIR $HOME/.config/fish
set -x SHELL /bin/bash
set -x TERM xterm-256color

set -x POWERLINE_CONFIG_COMMAND $HOME/.local/bin/powerline-config

if status --is-interactive
    set theme_name (cat $FISH_DIR/.base16-theme)
    eval sh $HOME/.config/base16-shell/scripts/$theme_name.sh

end

source $FISH_DIR/aliases.fish
