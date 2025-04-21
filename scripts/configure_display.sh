#!/bin/bash

echo "Configuration écran TFT Joy-IT 3.2..."

# Ajouter au config.txt
sudo tee -a /boot/config.txt > /dev/null <<EOT
# Configuration pour écran TFT Joy-IT 3.2
dtoverlay=spi1-1cs
dtoverlay=fb_ili9341,spi0-0,rotate=270,speed=32000000,dc_pin=24,reset_pin=25
EOT

echo "Ecran TFT configuré !"
