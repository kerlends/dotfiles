function nfunc
    if test (count $argv) -lt 1
        echo "No function name provided"
        return
    end

    set func_path $HOME/.config/fish/functions/$argv[1].fish

    vim $func_path

    source $func_path
    source $FISH_DIR/config.fish
end

