function mkcd
    if test (count $argv) -eq 0
        echo (set_color red)"error:" (set_color normal)"no arguments given"
    else if test (count $argv) -gt 1
        echo (set_color red)"error:" (set_color normal)"too many arguments"
    else
        mkdir -p $argv
        cd $argv
    end
end
