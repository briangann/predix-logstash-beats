#!/usr/bin/env bash
echo "Hello!"
echo "PORT is ${PORT}"
echo "HOME is ${HOME}"
FILEBEAT=${HOME}/filebeat-1.2.3-x86_64/filebeat
# NOTE: filebeat itself will duplicate output in its logs, so redirect to dev null, don't put it into syslog either
FILEBEAT_CMD="${FILEBEAT} -e -c ${HOME}/filebeat-pipe.yml 2>&1 > /dev/null"
#FILEBEAT_CMD="${FILEBEAT} -e -c ${HOME}/filebeat-pipe.yml"
CHISEL=${HOME}/chisel-bin/chisel_linux_amd64

#
# Filebeat extract
echo "Extracting filebeat..."
cd ${HOME}
tar xfz ${HOME}/tarballs/filebeat-1.2.3-x86_64.tar.gz

#
# Startup chisel client
#
echo "Starting up Chisel Client..."
cd ${HOME}
nohup ${CHISEL} client --keepalive 10s https://logstash-beats-bg.run.aws-usw02-pr.ice.predix.io 5000:0.0.0.0:5000 2>&1 | ${FILEBEAT_CMD} &
#nohup ${CHISEL} client --keepalive 10s https://logstash-beats-bg.run.aws-usw02-pr.ice.predix.io 5000:0.0.0.0:5000 &

# Get process list
ps -ef

#
echo "HOME is ${HOME}"
ls -l ${HOME}

#
# Startup web server
#
echo "Starting up python rest api..."
python ${HOME}/application-controller.py 2>&1 | ${FILEBEAT_CMD}
