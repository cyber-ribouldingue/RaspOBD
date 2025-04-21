#!/bin/bash

echo "=== Installation RaspOBD ==="

# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Activer SPI
echo "Activating SPI..."
sudo raspi-config nonint do_spi 0

# Installer dépendances
echo "Installing Python modules..."
sudo apt install -y python3-pip python3-venv python3-pygame python3-gpiozero python3-bluetooth

# Préparer environnement Python
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Configurer écran SPI pour Joy-It TFT
bash scripts/configure_display.sh

# Configurer Bluetooth
bash scripts/configure_bluetooth.sh

# Activer le service système
sudo cp systemd/raspobd-interface.service /etc/systemd/system/
sudo systemctl enable raspobd-interface.service

echo "Installation terminée. Reboot recommandé !"
