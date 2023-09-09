#!/bin/bash

# create python venv
python3 -m venv venv

status=$?

echo "$status"

source venv/bin/activate

# installing
pip3 install -r ./requirements.txt
deactivate
