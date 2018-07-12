if test (tty) = '/dev/tty1'
    exec startx
    xinput --set-prop 8 'libinput Accel Speed' '-0.9'
end

set -x PATH \
    /opt/android-sdk/tools/bin \
    $HOME/.yarn/bin \
    $HOME/.config/yarn/global/node_modules/.bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $HOME/.opam/system/bin \
    $HOME/.config/ocaml/bin \
    $PATH

set -x EDITOR nvim
set -x REACT_EDITOR nvim
set -x FISH_DIR $HOME/.config/fish
set -x SHELL /bin/bash
set -x ANDROID_HOME /opt/android-sdk

set -x POWERLINE_CONFIG_COMMAND $HOME/.local/bin/powerline-config

set phone_ip "192.168.1.11"
set vpn_ip "10.8.0.10"

if status --is-interactive
    set theme_name (cat $FISH_DIR/.base16-theme)
    eval sh $HOME/.config/base16-shell/scripts/$theme_name.sh

    eval (python -m virtualfish)

    set session_name "local"

    if test $SSH_CLIENT
        set client_ip (echo $SSH_CLIENT | awk '{print $1}')
        echo (date)": "$client_ip >> $HOME/.ssh.log
        if test $client_ip = $phone_ip
            set session_name "phone"
        else if test $client_ip = $vpn_ip
            set session_name "vpn"
        end
    end

    if test -z $TMUX
        tmux has-session -t $session_name > /dev/null
        if test $status -ne 0
            nvm use default
            exec tmux -2 new-session -s $session_name
        else
            exec tmux -2 attach-session -d -t $session_name
        end
    end
end

source $FISH_DIR/aliases.fish
