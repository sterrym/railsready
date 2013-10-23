#!/bin/bash
#
# Rails Ready
#
# Author: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Contributions from: Ryan McGeary <ryan@mcgeary.org>
#

ruby_version=$1
ruby_version_string=$2
ruby_source_url=$3
ruby_source_tar_name=$4
ruby_source_dir_name=$5
whichRuby=$6 # 1=source 2=RVM
script_runner=$(whoami)
whichServer=$7 # 1=unicorn 2=thin 3=passenger
whichDatabase=$8 # 1=mysql 2=postgresql 3=sqlite3
railsready_path=$9
log_file=$10


# echo "vars set: $ruby_version $ruby_version_string $ruby_source_url $ruby_source_tar_name $ruby_source_dir_name $whichRuby $whichServer $whichDatabase $railsready_path $log_file"
# echo "$whichServer $whichDatabase"

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"
echo -e "\nUpdating system"
sudo $pm -y update
echo "==> done..."

# Install build tools
echo -e "\n=> Installing build tools..."
sudo $pm -y install \
    wget curl build-essential clang \
    bison openssl zlib1g libqt4-dev \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev \
    libtool >> $log_file 2>&1
echo "==> done..."

echo -e "\n=> Installing libs needed for mysql, postgresql and sqlite..."
sudo $pm -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev libpq-dev >> $log_file 2>&1
echo "==> done..."

# Install git-core
echo -e "\n=> Installing git..."
sudo $pm -y install git-core >> $log_file 2>&1
echo "==> done..."

# Install nodejs for assets
echo -e "\n=> Installing Nodejs..."
sudo $pm -y install nodejs >> $log_file 2>&1
echo "==> done..."

# Install Nginx
echo -e "\n=> Installing Nginx..."
sudo $pm -y install nginx >> $log_file 2>&1
echo "==> done..."


if [ $whichDatabase -eq 1 ] ; then
    echo -e "\n=> Installing MySQL\n"
    sudo $pm install mysql-server mysql-client
elif [ $whichRuby -eq 2 ] ; then
    echo -e "\n=> Installing PostgreSQL\n"
    sudo $pm -y install postgresql
elif [ $whichRuby -eq 3 ] ; then
    echo -e "\n=> Installing SQLite3\n"
    sudo $pm -y install sqlite3
fi
# mysql-client-core-5.5
#  sudo apt-get install postgresql
# echo -e "\n=> Installing libs needed for sqlite and mysql..."
# sudo $pm -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev >> $log_file 2>&1
# echo "==> done..."
