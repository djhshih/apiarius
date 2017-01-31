#!/bin/bash

base_url=sftp-cancer.sanger.ac.uk

genome=$1
version=$2
table=$3

if (( $# != 3 )); then
	echo "usage ${0##*/} <genome> <version> <table>"
	exit 1
fi

# get credentials from .netrc with block format:
# machine <machine>
# login <login> [password <password>]
credentials=$(awk "/$base_url/ {f = 1} f && /login/ {print \$0; f = 0}" ~/.netrc)
tokens=($credentials)
username=${tokens[1]}
password=${tokens[3]}

# if no username stored, prompt
if [[ -z $username ]]; then
	echo -n "Login: "
	read username
fi

# if no password stored, prompt
if [[ -z $password ]]; then
	echo -n "Password: "
	read -s password
	echo
fi

mkdir -p ${genome}

# download file via sftp
curl \
	-k sftp://${base_url}/files/${genome}/cosmic/${version}/${table}.tsv.gz \
	--user "$username:$password" \
	| gunzip > ${genome}/${table}.tsv

