function exit
    if test -z $TMUX
        builtin exit
    else
        tmux detach
    end
end

