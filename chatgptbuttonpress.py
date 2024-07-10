#!/usr/bin/python3
import pygame
import sys

# Initialize Pygame
pygame.init()

# Screen dimensions
SCREEN_WIDTH, SCREEN_HEIGHT = 600, 400
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption('WASD Input Example')

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Player rectangle initial position and dimensions
player_x, player_y = SCREEN_WIDTH // 2, SCREEN_HEIGHT // 2
player_width, player_height = 50, 50

# Movement speed
player_speed = 5

clock = pygame.time.Clock()

# Main game loop
running = True
while running:
    screen.fill(BLACK)

    # Event handling
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Get the state of all keyboard keys
    keys = pygame.key.get_pressed()

    # Update player position based on keys
    if keys[pygame.K_w]:
        player_y -= player_speed
    if keys[pygame.K_s]:
        player_y += player_speed
    if keys[pygame.K_a]:
        player_x -= player_speed
    if keys[pygame.K_d]:
        player_x += player_speed

    # Draw the player rectangle
    pygame.draw.rect(screen, WHITE, (player_x, player_y, player_width, player_height))

    # Update the screen
    pygame.display.flip()

    # Cap the frame rate
    clock.tick(60)

# Quit Pygame
pygame.quit()
sys.exit()


while running:

    # Event handling
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
        
         # Get the state of all keyboard keys
        keys = pygame.key.get_pressed()

    # Update player position based on keys
        if keys[pygame.K_w]:
            up()
        if keys[pygame.K_s]:
            down()
        #if keys[pygame.K_a]:
            #player_x -= player_speed
        if keys[pygame.K_d]:
            right()
    
    #refresh screen
    pygame.display.flip()
    clock.tick(60)