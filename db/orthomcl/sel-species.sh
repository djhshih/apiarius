#!/bin/bash

set -o errexit
set -o nounset

infile=$1
outfile=$2
species_src=$3
species_dest=$4
sh_src=${species_src:0:4}
sh_dest=${species_dest:0:4}

if ! grep -E "${sh_src}).*${sh_dest}" $infile > $outfile; then
	# no match is found: try reversing the species
	if ! grep -E "${sh_dest}.*${sh_src}" $infile > $outfile; then
		echo "${species_src} or ${species_dest} is not found in $infile"
		exit 1
	else
		# species are found, but they are reversed: swap them back
		tmpfile=$(mktemp -t $outfile)
		paste <(cut -f 2 $outfile) <(cut -f 1 $outfile) > $tmpfile
		mv $tmpfile $outfile
	fi
fi

