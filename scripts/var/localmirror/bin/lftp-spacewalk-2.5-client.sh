#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

PWD=$(pwd)

mkdir -p ${MIRRORSDIR}/spacewalk/2.5-client/RHEL/7/
cd ${MIRRORSDIR}/spacewalk/2.5-client/RHEL/7/

http_proxy= https_proxy= /bin/lftp -e 'open http://yum.spacewalkproject.org/2.5-client/RHEL/7 && \
    mirror -c --delete \
    x86_64 && exit' &> ${SYNCSTATEDIR}/spacewalk-2.5-client

if [ $? -eq 0 ]; then
    /bin/touch ${SYNCSTATEDIR}/spacewalk-2.5-client
    ${SCRIPTSDIR}/build-spcw-setup-repo.sh
fi

cd $PWD
