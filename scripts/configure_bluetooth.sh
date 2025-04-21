#!/bin/bash

echo "Configuration Bluetooth pour OBD..."

# Activation bluetooth service
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Activation auto-pair OBD device
echo "OBD auto-pair configuration terminée."
