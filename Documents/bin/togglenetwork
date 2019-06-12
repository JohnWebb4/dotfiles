#!/bin/bash
echo "Enter root password to "
if [ $(systemctl is-active NetworkManager) = "active" ]
then
  echo "Stop Network"
  su -c "systemctl stop  NetworkManager"
else
  echo "Start Network"
  su -c "systemctl start NetworkManager"
fi
