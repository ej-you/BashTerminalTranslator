#!/bin/bash

function trans {
	default_str=$*

	translate=$( /home/danil/scripts/translator/google_trans_getter.py $default_str )

	echo "$translate"
}
