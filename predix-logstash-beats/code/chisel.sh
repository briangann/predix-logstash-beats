#!/usr/bin/env bash
echo "Hello!"
echo "PORT is ${PORT}"
if [ ! -d ${HOME}/logs ]; then
  echo "Creating log directory"
  mkdir ${HOME}/logs
fi
echo "Starting up chisel-server!"
${HOME}/chisel-bin/chisel_linux_amd64 server -v --port ${PORT} | tee ${HOME}/logs/chisel-server.log
