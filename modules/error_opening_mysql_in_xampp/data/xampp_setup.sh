

#!/bin/bash



# Stop any running instances of XAMPP

sudo /opt/lampp/lampp stop



# Remove XAMPP components

sudo /opt/lampp/uninstall



# Download the latest version of XAMPP

wget https://www.apachefriends.org/xampp-files/${XAMPP_VERSION}.tar.gz



# Extract the downloaded archive to /opt

sudo tar -xvf ${XAMPP_VERSION}.tar.gz -C /opt



# Change the ownership of the XAMPP directory to the current user

sudo chown -R $(whoami):$(whoami) /opt/lampp



# Start XAMPP

sudo /opt/lampp/lampp start



# Check if MySQL is running

/opt/lampp/bin/mysql -u root -p