#!/bin/bash

[ -f $1 ] || {
    echo "ERROR: File does not exist! ($1)"
    exit 1
}

/bin/awk '{if (/^.*<revision>[[:digit:]]+<\/revision>/) {print " <revision>"strftime("%s")"</revision>"} else {print}}' $1
