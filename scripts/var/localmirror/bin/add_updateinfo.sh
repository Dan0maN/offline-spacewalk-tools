#!/bin/bash

if [ ! -f /etc/localmirror/localmirror.conf ]; then
   echo "ERROR:  Unable to source /etc/localmirror/localmirror.conf"
   echo ""
   exit 1
fi

. /etc/localmirror/localmirror.conf

printusage() {
   echo ""
   echo "$0 UPDATEINFOXMLFILE REPODATADIR"
   echo "  UPDATEINFOXMLFILE - Pathname of updateinfo.xml file to inject into the repository"
   echo "  REPODATADIR - Pathname of the repodata directory for the repository"
   echo ""
}

if [ -z $1 ] || [ ! -f $1 ]; then
   echo "ERROR: ARG1 is not updateinfo.xml! ($1)"
   printusage
   exit 1
fi

if [ -z $2 ] || [ ! -d $2 ]; then
   echo "ERROR: ARG2 is not a directory! ($2)"
   printusage
   exit 1
fi
	
[ -e $2/*updateinfo.xml* ] && /bin/rm -f $2/*updateinfo.xml*

/bin/modifyrepo $1 $2 &>> ${SYNCSTATEDIR}/add-updateinfo
