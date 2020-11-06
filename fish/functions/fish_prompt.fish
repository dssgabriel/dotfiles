function fish_prompt
    set -l cyan (set_color white --bold)
    set -l normal (set_color normal)
    echo -e "[root@gnix" $cyan(basename $PWD)$normal"]# " 
end
