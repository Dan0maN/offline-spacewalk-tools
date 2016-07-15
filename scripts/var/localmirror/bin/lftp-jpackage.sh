#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
    echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

PWD=$(pwd)

mkdir -p ${MIRRORSDIR}/jpackage/5.0/generic
cd ${MIRRORSDIR}/jpackage/5.0/generic

http_proxy= https_proxy= /bin/lftp -e 'open http://mirrors.dotsrc.org/jpackage/5.0/generic && \
    mirror -c --delete \
    -i ".*asm-[[:digit:]].*rpm" \
    -i ".*c3p0-[[:digit:]].*rpm" \
    -i ".*cglib-[[:digit:]].*rpm" \
    -i ".*classpathx-mail-[[:digit:]].*rpm" \
    -i ".*concurrent-[[:digit:]].*rpm" \
    -i ".*excalibur-[[:digit:]].*rpm" \
    -i ".*excalibur-avalon-framework-api-[[:digit:]].*rpm" \
    -i ".*excalibur-avalon-framework-impl-[[:digit:]].*rpm" \
    -i ".*excalibur-avalon-logkit-[[:digit:]].*rpm" \
    -i ".*freemarker-[[:digit:]].*rpm" \
    -i ".*geronimo-specs-poms-[[:digit:]].*rpm" \
    -i ".*geronimo-jms-1.1-api-[[:digit:]].*rpm" \
    -i ".*glassfish-jaf-[[:digit:]].*rpm" \
    -i ".*hibernate3-[[:digit:]].*rpm" \
    -i ".*jakarta-commons-el-[[:digit:]].*rpm" \
    -i ".*jcommon-[[:digit:]].*rpm" \
    -i ".*jython-[[:digit:]].*rpm" \
    -i ".*oscache-[[:digit:]].*rpm" \
    -i ".*saxpath-[[:digit:]].*rpm" \
    -i ".*servletapi4-[[:digit:]].*rpm" \
    -i ".*sitemesh-[[:digit:]].*rpm" \
    -i ".*tomcat5-jsp-2.0-api-[[:digit:]].*rpm" \
    -i ".*tomcat5-servlet-2.4-api-[[:digit:]].*rpm" \
    -i ".*tomcat6-servlet-[[:digit:]].*rpm" \
    -i ".*velocity-dvsl-[[:digit:]].*rpm" \
    -i ".*velocity-tools-[[:digit:]].*rpm" \
    -i "repodata/" \
    -i "repoview/" \
    -i "list" \
    free && exit' &> ${SYNCSTATEDIR}/jpackage-5.0-generic-free

if [ $? -eq 0 ]; then
    /bin/touch ${SYNCSTATEDIR}/jpackage-5.0-generic-free
fi

cd $PWD
