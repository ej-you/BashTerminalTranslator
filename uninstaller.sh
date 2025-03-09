#!/bin/bash


# output colors
red_color="\033[31m"
yellow_color="\033[33m"
green_color="\033[32m"
default_color="\033[0m"


read -p 'Are you sure you want to UNINSTALL "Bash Translator"? [y, n] ' sure
if [ "$sure" = 'y' ]; then
    # clear strings with importing func in ~/.bashrc
    str_start_del="$(grep --line-number --max-count=1 --only-matching ^'# >>> Bash translate from Ej_you >>>' ~/.bashrc | sed -e s/\:.*//)"
    str_end_del=$(($str_start_del+2))

    sed -i "$str_start_del,${str_end_del}d" ~/.bashrc

    status=$?
    # something wrong
    if [ "$status" != '0' ]; then
        echo -e "${red_color}Something went wrong!!! Please, check your file \"~/.bashrc\"${default_color}"
        exit 1
    # alright
    else
        # remove file ~/.trans_working_dir
        rm ~/.trans_working_dir
    fi

    status=$?
    # something wrong
    if [ "$status" != '0' ]; then
        echo -e "${red_color}Something went wrong!!! Please, check your file \"~/.trans_working_dir\"${default_color}"
        exit 1
    # alright
    else
        echo -e "${green_color}\"Bash Translator\" was removed successfully!${default_color}"
    fi

else
    echo -e "${yellow_color}Removing was rejected${default_color}"
fi
