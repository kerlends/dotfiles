function nfunc
    if test (count $argv) -lt 1
        echo "No function name provided"
        return
    end

    vim $HOME/.config/fish/functions/$argv[1].fish
end

