#!/bin/bash
wget -O /tmp/$1.sh https://github.com/prydin/vra-utils/$1.sh
chmod +x /tmp/$1.sh
shift 
/tmp/$1.sh "$@"
rm -f /tmp/$1.sh
