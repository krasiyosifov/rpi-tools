#!/bin/bash

if [ "$1" = "" ]
then
  echo "Usage: $ generate-report.sh system-name"
  exit
fi

hashcat -b | tee "benchmark-report-$1.txt"
