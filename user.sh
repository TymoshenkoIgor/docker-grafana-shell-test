#!/usr/bin/bash

UID_MIN=$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)
UID_MAX=$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)

USERS=$(awk -F: -v min=$UID_MIN -v max=$UID_MAX '{
  if ($3 >= min && $3 <= max) print $1
}' /etc/passwd)

for user in $USERS; do
  if  lastlog -b 90 | grep "$user" > /dev/null;
  then 
    echo "$user is to delete"
    #For delete user just change "echo" command to the "deluser --remove-home $user"
  fi
done