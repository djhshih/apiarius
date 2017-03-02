#!/bin/bash

set -euo pipefail

# synapse client needs to already installed by:
#     pip install synapseclient

# get credentials from .netrc with block format:
# machine <machine>
# login <login> [password <password>]
credentials=$(awk "/synapse/ {f = 1} f && /login/ {print \$0; f = 0}" ~/.netrc)
tokens=($credentials)
username=${tokens[1]}
password=${tokens[3]}

if [[ -z $username || -z $password ]]; then
	synapse login --rememberMe
else
	synapse login -u $username -p $password --rememberMe
fi

synapse get $@

