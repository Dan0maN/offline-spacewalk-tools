#!/bin/bash
if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

/bin/mkdir -p ${MIRRORSDIR}/centos/7/updates/

/bin/rsync -aHSP --delete $1 \
    --delete-excluded \
    mirror.us.leaseweb.net::centos/7/updates/ ${MIRRORSDIR}/centos/7/updates/

if [ $? -eq 0 ]; then
    /bin/chown root.root ${MIRRORSDIR}/centos/7/updates/
    /bin/find ${MIRRORSDIR}/centos/7/updates/ -type d -exec /bin/chmod 0755 {} \; -exec /bin/chcon -t httpd_sys_content_t {} \;
    /bin/find ${MIRRORSDIR}/centos/7/updates/ -type f -exec /bin/chmod 0644 {} \; -exec /bin/chcon -t httpd_sys_content_t {} \;
    /bin/touch ${SYNCSTATEDIR}/centos-7-updates
    ${SCRIPTSDIR}/update_errata.sh updates
    ${SCRIPTSDIR}/build-spcw-setup-repo.sh
fi
