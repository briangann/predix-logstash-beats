#!/usr/bin/env bash
echo "Starting up Chisel Client..."
cd ${HOME}
${HOME}/chisel-bin/chisel_linux_amd64 client --keepalive 10s https://logstash-beats-bg.run.aws-usw02-pr.ice.predix.io 5000:0.0.0.0:5000
