import pygame
import gpiozero
import time
from screen_manager import ScreenManager
from obd_manager import OBDManager
import config

def main():
    pygame.init()
    pygame.mouse.set_visible(False)
    screen = pygame.display.set_mode((320, 240))
    manager = ScreenManager(screen)
    obd_manager = OBDManager()

    button_up = gpiozero.Button(config.BUTTON_UP)
    button_down = gpiozero.Button(config.BUTTON_DOWN)
    button_select = gpiozero.Button(config.BUTTON_SELECT)

    menu = ["Connexion OBD", "Tension Batterie", "Température Moteur", "Quitter"]
    current_selection = 0

    def refresh():
        manager.show_message(menu[current_selection])

    # Écran d'accueil
    manager.show_message("Bienvenue sur RaspOBD")
    time.sleep(2)
    refresh()

    while True:
        if button_up.is_pressed:
            current_selection = (current_selection - 1) % len(menu)
            refresh()
            time.sleep(0.3)

        if button_down.is_pressed:
            current_selection = (current_selection + 1) % len(menu)
            refresh()
            time.sleep(0.3)

        if button_select.is_pressed:
            if menu[current_selection] == "Connexion OBD":
                connected = obd_manager.connect()
                manager.show_message("OBD Connecté" if connected else "Erreur OBD")
            elif menu[current_selection] == "Tension Batterie":
                voltage = obd_manager.read_voltage()
                if voltage:
                    manager.show_message(f"Tension: {voltage}V")
                else:
                    manager.show_message("Erreur Lecture")
            elif menu[current_selection] == "Température Moteur":
                manager.show_message("À venir...")
            elif menu[current_selection] == "Quitter":
                pygame.quit()
                exit()
            time.sleep(1)
            refresh()

if __name__ == "__main__":
    main()
