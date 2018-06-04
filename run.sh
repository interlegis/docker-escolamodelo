#!/bin/sh

if [ ! -d /var/moodledata ]; then
  mkdir /var/moodledata;
fi

if [ ! -f /var/moodledata/placeholder ]; then 
  chown -R apache:apache /var/moodledata
  echo "placeholder" > /var/moodledata/placeholder
fi
chown apache:apache /var/moodledata
exec /usr/sbin/httpd -D FOREGROUND
