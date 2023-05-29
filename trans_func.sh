#!/bin/bash

function trans {
	default_str=$*

	translate=$( python3 ./google_trans_getter.py $default_str )

	echo "$translate"
}
