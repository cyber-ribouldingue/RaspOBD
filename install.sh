#!/bin/bash

echo "=== Début de l'installation de RaspOBD ==="

# Mise à jour complète du système
sudo apt update && sudo apt upgrade -y

# Activation SPI
echo "Activation de l'interface SPI..."
sudo raspi-config nonint do_spi 0

# Installation des paquets système nécessaires
echo "Installation des paquets nécessaires..."
sudo apt install -y python3-pip python3-venv python3-pygame python3-gpiozero git bluetooth pi-bluetooth bluez libbluetooth-dev

# Création d'un environnement virtuel Python
echo "Création de l'environnement virtuel Python..."
python3 -m venv venv
source venv/bin/activate

# Installation des modules Python standards
echo "Installation des dépendances Python (pygame, gpiozero)..."
pip install pygame gpiozero

# Installation spécifique de PyBluez compatible Python 3.11
echo "Installation de PyBluez depuis GitHub pour compatibilité Python 3.11..."
pip install git+https://github.com/pybluez/pybluez.git

# Suppression d'ancienne installation éventuelle de python-OBD
echo "Nettoyage éventuel d'une ancienne installation de python-OBD..."
cd ~
rm -rf python-OBD

# Installation de python-OBD depuis GitHub
echo "Clonage et installation de python-OBD..."
git clone https://github.com/brendan-w/python-OBD.git
cd python-OBD
sudo python3 setup.py install

# Retour dans le dossier du projet
cd ~/RaspOBD

# Configuration de l'affichage de l'écran TFT
echo "Configuration de l'écran TFT Joy-IT 3.2..."
bash scripts/configure_display.sh

# Configuration Bluetooth
echo "Configuration du Bluetooth..."
bash scripts/configure_bluetooth.sh

# Activation du service systemd pour démarrer l'interface au boot
echo "Activation du service RaspOBD au démarrage..."
sudo cp systemd/raspobd-interface.service /etc/systemd/system/
sudo systemctl enable raspobd-interface.service

echo "=== Installation terminée avec succès. ==="
echo "Veuillez redémarrer votre Raspberry Pi : sudo reboot"
