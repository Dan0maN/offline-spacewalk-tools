#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

/bin/mkdir -p ${MIRRORSDIR}/centos/
/bin/rsync -aHSP --delete $1 \
    --exclude="isos" \
    --exclude="2*/" \
    --exclude="3*/" \
    --exclude="4*/" \
    --exclude="5*/" \
    --exclude="6*/" \
    mirror.us.leaseweb.net::centos/ ${MIRRORSDIR}/centos/

if [ $? -eq 0 ]; then
    /bin/chown root.root ${MIRRORSDIR}/centos/
    /bin/find ${MIRRORSDIR}/centos/ -type d -exec /bin/chmod 0755 {} \; -exec /bin/chcon -t httpd_sys_content_t {} \;
    /bin/find ${MIRRORSDIR}/centos/ -type f -exec /bin/chmod 0644 {} \; -exec /bin/chcon -t httpd_sys_content_t {} \;
    /bin/touch ${SYNCSTATEDIR}/centos-7-full
    ${SCRIPTSDIR}/update_errata.sh updates
    ${SCRIPTSDIR}/build-spcw-setup-repo.sh
fi
