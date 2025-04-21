#!/bin/bash

echo "=== Installation RaspOBD ==="

# Mise à jour système
sudo apt update && sudo apt upgrade -y

# Activation SPI
echo "Activation SPI..."
sudo raspi-config nonint do_spi 0

# Installation dépendances
echo "Installation des modules Python nécessaires..."
sudo apt install -y python3-pip python3-venv python3-pygame python3-gpiozero python3-bluetooth bluetooth pi-bluetooth bluez

# Préparation environnement Python
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Configuration écran TFT
bash scripts/configure_display.sh

# Configuration Bluetooth
bash scripts/configure_bluetooth.sh

# Activer le service systemd pour l'interface
sudo cp systemd/raspobd-interface.service /etc/systemd/system/
sudo systemctl enable raspobd-interface.service

echo "=== Installation terminée. Reboot recommandé ! ==="
