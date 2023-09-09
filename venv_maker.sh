#!/bin/bash


# continue installation if python and python3.10-venv is installed
function continue_if_status_ok() {
    source venv/bin/activate

    # installing
    pip3 install -r ./requirements.txt
    deactivate
}


# create python venv
python3 -m venv venv &> /dev/null

# check output (error or OK)
status=$?

# if not error
if [ "$status" = "0" ]; then
    continue_if_status_ok
else
    # ask user to install python and python3.10-venv
    read -p "You NEED INSTALL python3 and python3.10-venv. Do it? [y, n] " install_py_venv

    if [ "$install_py_venv" = "y" ]; then
        # current user
        cur_user=$(whoami)

        # install python and python3.10-venv and continue installation
        if [ "$cur_user" = 'root' ]; then
            apt update
            apt install python3 python3.10-venv
        else
            sudo apt update
            sudo apt install -y python3 python3.10-venv
        fi
        echo "Continue translator installation!"
        python3 -m venv venv &> /dev/null
        continue_if_status_ok
    else
        echo "INSTALLATION REJECTED!"
    fi
fi
