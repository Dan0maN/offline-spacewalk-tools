#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

UPSTREAMREPOS="${MIRRORSDIR}/centos/7/os/ ${MIRRORSDIR}/centos/7/updates/ ${MIRRORSDIR}/spacewalk/2.5-client/"
for d in `echo $UPSTREAMREPOS`; do
    if [ ! -d $d ]; then
        echo "Unable to access $d.  Aborting."
        exit 1
    fi
done

[ -d ${MIRRORSDIR}/spcw-setup/2.5/el7/x86_64/RPMS/ ] || mkdir -p ${MIRRORSDIR}/spcw-setup/2.5/el7/x86_64/RPMS/

for f in `/bin/find $UPSTREAMREPOS \
    -iname m2crypto-* \
    -o -iname libnl-* \
    -o -iname pyOpenSSL-* \
    -o -iname pygobject2-* \
    -o -iname python-dmidecode-* \
    -o -iname python-ethtool-* \
    -o -iname python-gudev-* \
    -o -iname python-hwdata-* \
    -o -iname usermode-* \
    -o -iname libxml2-* \
    -o -iname rhn-check-* \
    -o -iname rhn-client-tools-* \
    -o -iname rhn-setup-* \
    -o -iname rhnsd-* \
    -o -iname yum-rhn-plugin-* \
    -o -iname rhnlib-*` \
; do
    [ -f $f ] || /bin/cp $f mkdir -p ${MIRRORSDIR}/spcw-setup/2.5/el7/x86_64/RPMS/
done

/bin/touch ${SYNCSTATEDIR}/
