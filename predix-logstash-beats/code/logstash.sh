#!/usr/bin/env bash
echo "HOME is ${HOME}"
FILEBEAT=${HOME}/filebeat-1.2.3-x86_64/filebeat
# NOTE: filebeat itself will duplicate output in its logs, so redirect to dev null, don't put it into syslog either
FILEBEAT_CMD="${FILEBEAT} -e -c ${HOME}/filebeat-pipe.yml 2>&1 > /dev/null"
#FILEBEAT_CMD="${FILEBEAT} -e -c ${HOME}/filebeat-pipe.yml"
CHISEL=${HOME}/chisel-bin/chisel_linux_amd64
LOGSTASH=${HOME}/logstash-2.3.4/bin/logstash
LOGSTASH_CONF=${HOME}/logstash/logstash-beats.conf
echo "LOGSTASH with BEATS!"
#
# Extract filebeat tarball
#
echo "Extracting filebeat..."
cd ${HOME}
tar xfz ${HOME}/tarballs/filebeat-1.2.3-x86_64.tar.gz
#
# Start Chisel
#
echo "Starting up chisel-server piped into filebeat!"
nohup ${CHISEL} server --port ${PORT} 2>&1 | ${FILEBEAT_CMD} &
#nohup ${CHISEL} server --port ${PORT} &
echo "chisel-server started!"
#
# Setup logstash
#
echo "Setting up logstash environment..."
cd ${HOME}
echo "Extracting Java JRE"
tar xfz ${HOME}/tarballs/jre-8u71-linux-x64.tar.gz
export JAVA_HOME=${HOME}/jre1.8.0_71
# needed?
export JRE_HOME=${HOME}/jre1.8.0_71
echo "Adding java to our path"
export PATH=${PATH}:${JAVA_HOME}/bin
echo "PATH is ${PATH}"
#sed -i "s/CF_PORT/${PORT}/g" ${HOME}/logstash/logstash-beats.conf
echo "content of logstash-beats.conf"
cat ${HOME}/logstash/logstash-beats.conf
echo "Extracting logstash"
tar xfz ${HOME}/tarballs/logstash-2.3.4.tar.gz
#echo "Listing our plugins"
#${HOME}/logstash-2.3.4/bin/logstash-plugin list --verbose
# Not needed, beats is included
#echo "Installing beats plugin"
#${HOME}/logstash-2.3.4/bin/logstash-plugin install logstash-input-beats
#echo "Listing our plugins after install"
#${HOME}/logstash-2.3.4/bin/logstash-plugin list --verbose
echo "Contents of HOME ${HOME}"
ls -l ${HOME}
echo "Starting up logstash with beats!"
#${LOGSTASH} -f ${LOGSTASH_CONF} 2>&1 | ${FILEBEAT_CMD}
echo "CMD is ${LOGSTASH} -f ${LOGSTASH_CONF} | ${FILEBEAT_CMD}"
${LOGSTASH} -f ${LOGSTASH_CONF} | ${FILEBEAT_CMD}
