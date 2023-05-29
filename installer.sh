#!/bin/bash

echo "Start installing..."

user_dir=$(echo ~)

chmod +x ./trans_func.sh
echo "Python requirements installing..."
pip3 install -r ./requirements.txt

echo "Finish installing..."
echo "source $(pwd)/trans_func.sh" >> $user_dir/.bashrc
