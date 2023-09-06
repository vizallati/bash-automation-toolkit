#!/bin/bash


linux_distro=ubuntu

if grep -i $linux_distro /etc/os-release
then
    sleep 1
    echo "$linux_distro is supported, proceeding to update packages..."
    sleep 1
    sudo apt-get update && sudo apt upgrade -y
    sleep 2
    echo "All packages on this $linux_distro have been updated successfully"
else
    echo "Sorry your distribution is not supported by this script"
fi

