#! /bin/bash

# Minimal installation

APPS=$(sed -e '1,/# MINIMAL/d' apps.list)

sudo apt update
sudo apt install -y $APPS 
