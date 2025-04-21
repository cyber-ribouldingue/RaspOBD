#!/bin/bash

echo "Activation Bluetooth..."

# Activer Bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

echo "Bluetooth configuré !"
