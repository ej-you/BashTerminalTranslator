#!/bin/bash

echo "Start installing..."

# user's home directory
user_dir=$(echo ~)
# working directory
cur_dir=$(pwd)

# write working directory into "/home/user/.trans_working_dir" file
echo "$cur_dir" > $user_dir/.trans_working_dir

# make files "trans_func.sh" and "venv_maker.sh" executable
chmod +x ./trans_func.sh
chmod +x ./venv_maker.sh

# installing python requirements
echo "Python requirements installing..."
./venv_maker.sh
echo "Finish installing..."

# add source file "./trans_func.sh" into /home/user/.bashrc
echo "
# <<< Bash translate from Ej_you >>>" >> $user_dir/.bashrc
echo "source $(pwd)/trans_func.sh" >> $user_dir/.bashrc
echo "# <<< Bash translate >>>" >> $user_dir/.bashrc

echo "Done!"
