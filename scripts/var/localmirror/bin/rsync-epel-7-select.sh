#!/bin/bash
if [ ! -f /etc/localmirror/localmirror.conf ]; then
    /bin/echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
    /bin/echo ""
    exit 1
fi

. /etc/localmirror/localmirror.conf

/bin/mkdir -p ${MIRRORSDIR}/epel/7/x86_64/
/bin/rsync -aHSP --delete --delete-excluded $1 \
    --include="*/" \
    --include="*apache-commons-chain*rpm" \
    --include="*apache-commons-discovery*rpm" \
    --include="*apache-commons-fileupload*rpm" \
    --include="*createrepo_c*rpm" \
    --include="*dojo*rpm" \
    --include="*epel-release*rpm" \
    --include="*geronimo-validation*rpm" \
    --include="*haveged*rpm" \
    --include="*htop*rpm" \
    --include="*jabberd*rpm" \
    --include="*jabberpy*rpm" \
    --include="*jboss-jsf-2.1-api*rpm" \
    --include="*jboss-jsp-2.2-api*rpm" \
    --include="*jboss-jstl-1.2-api*rpm" \
    --include="*liquibase*rpm" \
    --include="*libdb4*rpm" \
    --include="*libgsasl*rpm" \
    --include="*libstemmer*rpm" \
    --include="*lynis*rpm" \
    --include="*mchange-commons*rpm" \
    --include="*mongodb*rpm" \
    --include="*ncdu*rpm" \
    --include="*nginx*rpm" \
    --include="*perl-Authen-PAM*rpm" \
    --include="*perl-BerkeleyDB*rpm" \
    --include="*perl-HTTP-ProxyAutoConfig*rpm" \
    --include="*perl-Net-Jabber*rpm" \
    --include="*perl-Net-XMPP*rpm" \
    --include="*perl-Time-ParseDate*rpm" \
    --include="*perl-XML-Stream*rpm" \
    --include="*portlet-2.0-api*rpm" \
    --include="*python-anyjson*rpm" \
    --include="*python-blinker*rpm" \
    --include="*python-bson*rpm" \
    --include="*python-debian*rpm" \
    --include="*python-flask*rpm" \
    --include="*python-httplib2*rpm" \
    --include="*python-itsdangerous*rpm" \
    --include="*python-meld3*rpm" \
    --include="*python-oauth2*rpm" \
    --include="*python-okaara*rpm" \
    --include="*python-pymongo*rpm" \
    --include="*python-pymongo-gridfs*rpm" \
    --include="*python-qrcode-core*rpm" \
    --include="*python-simplejson*rpm" \
    --include="*python-werkzeug*rpm" \
    --include="*rubygem-ansi*rpm" \
    --include="*rubygem-gssapi*rpm" \
    --include="*rubygem-mime-types*rpm" \
    --include="*rubygem-rack*rpm" \
    --include="*rubygem-rest-client*rpm" \
    --include="*struts*rpm" \
    --include="*supervisor*rpm" \
    --include="*udns*rpm" \
    --include="*v8*rpm" \
    --include="*yaml-cpp*rpm" \
    --include="repodata/*" \
    --include="repoview/*" \
    --exclude="*" \
    mirror.us.leaseweb.net::epel/7/x86_64/ ${MIRRORSDIR}/epel/7/x86_64/

if [ $? -eq 0 ]; then
    /bin/touch ${SYNCSTATEDIR}/epel-7-select
fi
