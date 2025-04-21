import pygame

class ScreenManager:
    def __init__(self, screen):
        self.screen = screen

    def show_message(self, text, color=(255,255,255)):
        self.screen.fill((0, 0, 0))
        font = pygame.font.Font(None, 40)
        rendered = font.render(text, True, color)
        rect = rendered.get_rect(center=(160, 120))
        self.screen.blit(rendered, rect)
        pygame.display.update()
