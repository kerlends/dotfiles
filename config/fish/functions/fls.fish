function fls
    echo -e "\nLocal fish functions:\n"

    set c 1

    for _func in (ls $FISH_DIR/functions)
        set _func_name (echo $_func | sed 's/\.fish//g')
        echo -e "\t$c. $_func_name\n"
        set c (math "$c+1")
    end
end

