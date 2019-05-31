echo "Enter root password to start Tor service"
su -c "systemctl start tor.service"
tor-browser
su -c "systemctl stop tor.service"
echo "Stopped tor service"
