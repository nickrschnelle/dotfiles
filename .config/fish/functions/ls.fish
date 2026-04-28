function ls
    set count (eza --color=never --icons=never -1 --all $argv 2>/dev/null | wc -l | string trim)
    set height (tput lines)

    if test $count -gt $height
        set cols (math "min(3, ceil($count / $height))")
        eza --color=always --icons=always --all --sort=type --grid --width=(math "$cols * (($COLUMNS - 2) / $cols)") $argv
    else
        eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all --sort=type $argv
    end
end
