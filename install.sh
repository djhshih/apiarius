#!/bin/bash

set -o errexit
set -o nounset

DESTDIR=${DESTDIR:-/usr/local}

basepath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# install mella after updating basepath
sed "s|basepath=.*|basepath=$basepath|" $basepath/bin/mella > $DESTDIR/bin/mella
chmod +x $DESTDIR/bin/mella

