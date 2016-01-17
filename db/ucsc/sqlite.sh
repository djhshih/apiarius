#!/bin/bash

name=$1
basename=${name##*/}

sqlite3 ${name}.db --init ${name}.sqlite << EOF
.separator "\t"
.import ${name}.txt ${basename}
EOF

