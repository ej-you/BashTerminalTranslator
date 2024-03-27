#!/bin/bash


# output colors
red_color="\033[31m"
yellow_color="\033[33m"
green_color="\033[32m"
default_color="\033[0m"


# continue installation if python and python3.10-venv is installed
function continue_if_status_ok() {
    source venv/bin/activate

    # installing
    pip3 install -r ./requirements.txt
    deactivate

    # user's home directory
    user_dir=$(echo ~)

    echo -e "${yellow_color}Finish installing...${default_color}"

    # add source file "./trans_func.sh" into /home/user/.bashrc
    echo -e "\n# >>> Bash translate from Ej_you >>>" >> "$user_dir"/.bashrc
    echo "source $(pwd)/trans_func.sh" >> "$user_dir"/.bashrc
    echo "# <<< Bash translate <<<" >> "$user_dir"/.bashrc

    echo -e "${green_color}Done!${default_color}"
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
        echo -e "${yellow_color}Continue translator installation!${default_color}"
        python3 -m venv venv &> /dev/null
        continue_if_status_ok
    else
        echo -e "${red_color}Installation rejected!${default_color}"
    fi
fi
