#!/bin/bash

echo "=== Installation RaspOBD ==="

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Activation SPI
echo "Activation SPI..."
sudo raspi-config nonint do_spi 0

# Installation des dépendances systèmes
echo "Installation des paquets nécessaires..."
sudo apt install -y python3-pip python3-venv python3-pygame python3-gpiozero python3-bluetooth bluetooth pi-bluetooth bluez git

# Préparer un environnement Python
echo "Création environnement virtuel Python..."
python3 -m venv venv
source venv/bin/activate

# Installer bibliothèques Python standards
echo "Installation des dépendances Python..."
pip install pygame gpiozero pybluez

# Installer python-OBD depuis GitHub (solution compatible Raspberry Pi)
echo "Installation de python-OBD depuis GitHub..."
cd ~
git clone https://github.com/brendan-w/python-OBD.git
cd python-OBD
sudo python3 setup.py install
cd ~/RaspOBD  # Retour dans le dossier du projet

# Configurer l'écran TFT
echo "Configuration de l'écran TFT..."
bash scripts/configure_display.sh

# Configurer Bluetooth
echo "Configuration du Bluetooth..."
bash scripts/configure_bluetooth.sh

# Activer le service pour lancer l'interface au démarrage
echo "Activation du service RaspOBD..."
sudo cp systemd/raspobd-interface.service /etc/systemd/system/
sudo systemctl enable raspobd-interface.service

echo "=== Installation terminée. Redémarrage recommandé ! ==="
