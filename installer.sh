#!/bin/bash

# installer func
function install() {
    echo "Start installing..."

    # user's home directory
    user_dir=$(echo ~)
    # working directory
    cur_dir=$(pwd)

    echo "$user_dir $cur_dir"

    # write working directory into "/home/user/.trans_working_dir" file
    echo "$cur_dir" > $user_dir/.trans_working_dir

    # make files "trans_func.sh" and "venv_maker.sh" executable
    chmod +x ./trans_func.sh
    chmod +x ./venv_maker.sh

    # installing python requirements
    echo "Python requirements installing..."
    ./venv_maker.sh
}


read -p "Have you read the instruction (README.md)? [type yes if true] " confirm
if [ "$confirm" = "yes" ]; then
    install
else
    echo "Please, read the instruction (cat README.md) and try to install translator again!"
fi
