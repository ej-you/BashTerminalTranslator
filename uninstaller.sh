#!/bin/bash

read -p 'Are you sure you want to UNINSTALL "Bash Translator"? [y, n] ' sure
if [ "$sure" = 'y' ]; then
    # clear strings with importing func in ~/.bashrc
    str_start_del="$(grep --line-number --max-count=1 --only-matching ^'# >>> Bash translate from Ej_you >>>' ~/.bashrc | sed -e s/\:.*//)"
    str_end_del=$(($str_start_del+2))

    sed -i "$str_start_del,${str_end_del}d" ~/.bashrc

    status=$?
    # something wrong
    if [ "$status" != '0' ]; then
        echo 'Something went wrong!!! Please, check your file "~/.bashrc"'
    # alright
    else
        # remove file ~/.trans_working_dir
        rm ~/.trans_working_dir
    fi

    status=$?
    # something wrong
    if [ "$status" != '0' ]; then
        echo 'Something went wrong!!! Please, check your files "~/.bashrc" and "~/.trans_working_dir"'
    # alright
    else
        echo '"Bash Translator" was removed successfully!'
    fi

else
    echo 'REMOVING REJECTED!'
fi
