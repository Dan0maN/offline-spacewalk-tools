#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    /bin/echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    /bin/echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

if [ -z $1 ]; then
    /bin/echo "ERROR:  ARG1 is missing!"
    /bin/echo ""
    exit 1
fi

if [ ! -f ${CEFSFILE} ]; then
    /bin/echo "ERROR:  ${CEFSFILE} doesn't exist!"
    /bin/echo ""
    exit 1
fi

${SCRIPTSDIR}/generate_updateinfo.py ${CEFSFILE}

case $1 in
    "os")
       	TEMPFILE=$(/bin/mktemp)
       	${SCRIPTSDIR}/bump_revision.sh ${MIRRORSDIR}/centos/7/os/x86_64/repodata/repomd.xml > ${TEMPFILE}
        if [ -s ${TEMPFILE} ]; then
            /bin/mv ${TEMPFILE} ${MIRRORSDIR}/centos/7/os/x86_64/repodata/repomd.xml
            /bin/chmod 0644 ${MIRRORSDIR}/centos/7/os/x86_64/repodata/repomd.xml
            /bin/chcon -t httpd_sys_content_t ${MIRRORSDIR}/centos/7/os/x86_64/repodata/repomd.xml
        fi
        ${SCRIPTSDIR}/add_updateinfo.sh ${STAGINGDIR}/updateinfo-7/updateinfo.xml ${MIRRORSDIR}/centos/7/os/x86_64/repodata

        TEMPFILE=$(/bin/mktemp)
        ${SCRIPTSDIR}/bump_revision.sh ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml > ${TEMPFILE}
        if [ -s ${TEMPFILE} ]; then
            /bin/mv ${TEMPFILE} ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
            /bin/chmod 0644 ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
            /bin/chcon -t httpd_sys_content_t ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
        fi
        ${SCRIPTSDIR}/add_updateinfo.sh ${STAGINGDIR}/updateinfo-7/updateinfo.xml ${MIRRORSDIR}/centos/7/updates/x86_64/repodata
        ;;
    "updates")
        TEMPFILE=$(/bin/mktemp)
        ${SCRIPTSDIR}/bump_revision.sh ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml > ${TEMPFILE}
        if [ -s ${TEMPFILE} ]; then
            /bin/mv ${TEMPFILE} ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
            /bin/chmod 0644 ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
            /bin/chcon -t httpd_sys_content_t ${MIRRORSDIR}/centos/7/updates/x86_64/repodata/repomd.xml
        fi
        ${SCRIPTSDIR}/add_updateinfo.sh ${STAGINGDIR}/updateinfo-7/updateinfo.xml ${MIRRORSDIR}/centos/7/updates/x86_64/repodata
        ;;
    *)
        /bin/echo "ERROR:  Unsupported repository"
        /bin/echo ""
        exit 1
        ;;
esac
