#!/bin/sh

# set apache as owner/group
if [ "$FIX_OWNERSHIP" != "" ]; then
    chown -R apache:apache /app
fi

# display logs
#tail -F /var/log/apache2/*log &

echo "[i] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
