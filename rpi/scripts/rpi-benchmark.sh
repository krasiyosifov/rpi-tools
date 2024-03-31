#!/bin/bash
. rpi-health.sh
sysbench cpu --cpu-max-prime=20000 --threads=4 --time=600 run
. rpi-health.sh
