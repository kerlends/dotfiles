function b16
    if test (count $argv) = 0
        echo -e "Usage:\n"
        echo -e "   b16 ls\t\tlist all base16 themes"
        echo -e "   b16 set <theme>\tset base16 theme\n"
        return
    end

    if test $argv[1] = 'ls'
        base16-ls $argv[1..-1]
    else if test $argv[1] = 'set'
        if test (count $argv) != 2
            echo "No theme specified"
            return
        end

        base16-set $argv[2]
    end
end

