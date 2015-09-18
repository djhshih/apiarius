#!/bin/bash

infile=$1
outfile=$2
tmpfile=$(mktemp -t one2one)

#trap "rm $tmpfile" EXIT

head -n 1 $infile > $tmpfile
grep 'ortholog_one2one' $infile >> $tmpfile
cut -f 1,2 $tmpfile > $outfile

