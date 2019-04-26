#!/bin/bash
# It's annoying to set up psql dbs every time you set up a django project. This script should ease the pain a bit.

echo Hello, what would you like to name the database??
read -p 'DB Name: ' db_name
echo What username would you like?
read -p 'DB User: ' db_user
echo What password would you like for $db_user?
read -p 'Password: ' db_password
echo I am creating a database called $db_name, a user called $db_user, and password $db_password

sudo -u postgres -H -- createdb $db_name
sudo -u postgres -H -- createuser $db_user
sudo -u postgres -H -- psql -U postgres -d $db_name -c "ALTER USER $db_user WITH PASSWORD '$db_password'"
sudo -u postgres -H -- psql -U postgres -d $db_name -c "GRANT ALL PRIVILEGES ON DATABASE $db_name TO $db_user"
sudo -u postgres -H -- psql -U postgres -d $db_name -c "ALTER USER $db_user CREATEDB"

echo Done!
exit
