function dl
    set dir /mnt/media/Files

    if test (count $argv) -eq 0
        transmission-remote -l
        return
    end

    switch $argv[1]
        case t
            set dir $dir/TV
        case m
            set dir $dir/Movies
     end


    transmission-remote -w $dir -a $argv[2]
end

