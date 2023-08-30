#!/bin/bash

package=$1

if command -v $package >/dev/null 2>&1
then
    echo "$package is already installed."
else
    echo "$package is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y $package
fi
