#!/usr/bin/env bash
echo "Prepping filebeat..."
cd ${HOME}
tar xfz ${HOME}/tarballs/filebeat-1.2.3-x86_64.tar.gz
echo "Starting up filebeat!"
# NOTE this is very verbose, force it to not syslog and dump everything to dev null
${HOME}/filebeat-1.2.3-x86_64/filebeat -e -c ${HOME}/filebeat-watch.yml 2>&1 > /dev/null
