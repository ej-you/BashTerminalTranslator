#!/bin/bash

# get workdir
trans_dir=$(cat ./.trans_working_dir)

function trans {
  # get text (as args)
	default_str=$*

  # use python func to translate
	translate=$( $trans_dir/venv/bin/python3 $trans_dir/google_trans_getter.py $default_str )

  # output translation
	echo "$translate"
}
