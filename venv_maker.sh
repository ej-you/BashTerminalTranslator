#!/bin/bash

# create python venv
python3 -m venv venv
source venv/bin/activate

# installing
pip3 install -r ./requirements.txt
deactivate
