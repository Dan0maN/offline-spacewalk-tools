#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

printusage() {
    echo ""
    echo "$0 OUTPUTFILE"
    echo "  OUTPUTFILE - Pathname of the output file"
    echo ""
}

TEMPFILE=$(/bin/mktemp)

http_proxy="" https_proxy="" all_proxy=$INETPROXY /bin/curl -po ${TEMPFILE} $1 https://raw.githubusercontent.com/stevemeier/cefs/master/errata.latest.xml

if [ $? -eq 0 ] && [ -s ${TEMPFILE} ]; then
    mv ${TEMPFILE} ${CEFSFILE}
fi
