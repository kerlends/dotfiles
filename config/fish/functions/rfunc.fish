function rfunc
    if test (count $argv) -lt 1
        echo "No function name specified"
        return
    end

    set -g f_name $argv[1]
    set -g f_path $FISH_DIR/functions/$f_name.fish

    function _confirm_prompt
        echo "Delete fish function $f_name? [y/N] "
    end
    
    function _confirm
        while true
            read -l -p _confirm_prompt confirm
            switch $confirm
                case Y y
                    return 0
                case '' N n
                    return 1
            end
        end
    end

    if _confirm
        rm $f_path
        echo "Deleted file: $f_path"
    end
end

