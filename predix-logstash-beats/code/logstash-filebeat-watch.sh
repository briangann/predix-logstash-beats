#!/usr/bin/env bash
echo "LOGSTASH with BEATS!"
ls -l /etc
if [ ! -d ${HOME}/logs ]; then
  echo "Creating log directory"
  mkdir ${HOME}/logs
fi
# Setup beats for this too
echo "Prepping filebeat..."
cd ${HOME}
tar xfz ${HOME}/tarballs/filebeat-1.2.3-x86_64.tar.gz
echo "Starting up filebeat!"
# NOTE: this is very noisy, so redirect to dev null, don't put it into syslog either
nohup ${HOME}/filebeat-1.2.3-x86_64/filebeat -e -c ${HOME}/filebeat.yml 2>&1 > /dev/null &
#
# now chisel
#
echo "Starting up chisel-server!"
nohup ${HOME}/chisel-bin/chisel_linux_amd64 server --port ${PORT} 2>&1 > ${HOME}/logs/chisel-server.log &
echo "chisel-server started!"
ls -l ${HOME}
echo "Prepping logstash environment..."
cd ${HOME}
echo "Extracting Java JRE"
tar xfz ${HOME}/tarballs/jre-8u71-linux-x64.tar.gz
export JAVA_HOME=${HOME}/jre1.8.0_71
# needed?
export JRE_HOME=${HOME}/jre1.8.0_71
echo "Adding java to our path"
export PATH=${PATH}:${JAVA_HOME}/bin
echo "PATH is ${PATH}"
ls -l ${HOME}
echo "HOME is ${HOME}"
#sed -i "s/CF_PORT/${PORT}/g" ${HOME}/logstash/logstash-beats.conf
echo "logstash-beats.conf"
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
echo "Starting up logstash with beats!"
${HOME}/logstash-2.3.4/bin/logstash -f ${HOME}/logstash/logstash-beats.conf -l ${HOME}/logs/logstash.log 2> ${HOME}/logs/logstash-stderr.log
