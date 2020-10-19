#!/bin/sh -l

starttime=$(date)
echo "::set-output name=starttime::$starttime"
/usr/bin/ansible-playbook $1 /playbooks/
endtime=$(date)
echo "::set-output name=endtime::$endtime"