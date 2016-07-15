#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    /bin/echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    /bin/echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

/bin/mkdir -p ${MIRRORSDIR}/postgresql/repos/yum/9.5/redhat/rhel-7-x86_64/

/bin/rsync -aHSP --delete $1 \
    download.postgresql.org::pgsql-ftp/repos/yum/9.5/redhat/rhel-7-x86_64/ ${MIRRORSDIR}/postgresql/repos/yum/9.5/redhat/rhel-7-x86_64/

if [ $? -eq 0 ]; then
    /bin/touch ${SYNCSTATEDIR}/postgresql-9.5
fi
