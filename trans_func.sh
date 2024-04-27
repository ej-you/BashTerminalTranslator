#!/bin/bash

# get workdir
trans_dir=$(cat ~/.trans_working_dir)

function trans {
  # get text (as args)
	default_str=$*

  # "translate one word" mode
  if [ -n "$default_str" ]; then
    # use python func to translate
    translate=$( "$trans_dir"/venv/bin/python3 "$trans_dir"/google_trans_getter.py "$default_str" )

    # output translation
    echo "$translate"

  # "command line" mode
  else
    "$trans_dir"/venv/bin/python3 "$trans_dir"/google_trans_getter.py
  fi
}
