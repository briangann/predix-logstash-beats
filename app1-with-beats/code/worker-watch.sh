#!/usr/bin/env bash
echo "Hello!"
echo "PORT is ${PORT}"
ls -l ${HOME}
echo "Starting up python rest api..."
ls -l ${HOME}
echo "HOME is ${HOME}"
mkdir ${HOME}/mylogs
python ${HOME}/application-controller.py 2>&1 | tee ${HOME}/mylogs/application-controller.log
