#!/bin/bash

name=$1
basename=${name##*/}

sqlite3 ${name}.db << EOF
.read ${name}.sqlite
.separator "\t"
.import ${name}.txt ${basename}
EOF

