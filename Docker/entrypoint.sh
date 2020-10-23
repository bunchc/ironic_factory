#!/bin/sh -l

starttime=$(date)
echo "::set-output name=starttime::$starttime"
/usr/bin/ansible-playbook --version

if [ -z "$2" ]; then
  /usr/bin/ansible-playbook $1
else
  /usr/bin/ansible-playbook -i $2 $1
fi

endtime=$(date)
echo "::set-output name=endtime::$endtime"