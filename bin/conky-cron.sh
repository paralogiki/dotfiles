#!/bin/bash
# Used to launch conky from crontab
export DISPLAY=:0
while read line ; do
echo $line | grep -vqe "^#"
if [ $? -eq 0 ]; then export $line; fi
done < /home/USER/.dbus/session-bus/$(cat /var/lib/dbus/machine-id)-0

/usr/bin/conky -q -c /home/USER/.conkyrc
