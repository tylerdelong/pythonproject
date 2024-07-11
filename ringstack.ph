#!/usr/bin/python3
import pygame
import sys
import time

pygame.init()

#define screen size.
SCREEN = pygame.display.set_mode((1280, 720))

#define screen title
pygame.display.set_caption('Tower of hanoi')

clock = pygame.time.Clock()

#load text intructions
white = (255, 255, 255)
black = (0, 0, 0)
wait1 = (300)
dela = ''

font = pygame.font.Font('freesansbold.ttf', 20)

wtext = font.render('Press w to pick piece up', True, white)
stext = font.render('Press s to put piece down', True, white)
atext = font.render('Press a to move piece and cursor left', True, white)
dtext = font.render('Press d to move piece and cursor right', True, white)
rtext = font.render('Press r to reset', True, white)

#import base image defined on pole1 and define size and position and table
pole1 = pygame.image.load('base.png').convert_alpha()
pole2 = pygame.image.load('base.png').convert_alpha()
pole3 = pygame.image.load('base.png').convert_alpha()
polesize = (400, 400)
pole1 = pygame.transform.scale(pole1, polesize)
pole2 = pygame.transform.scale(pole2, polesize)
pole3 = pygame.transform.scale(pole3, polesize)
pole1pos = x, y = 50, 300
pole2pos = x, y = 450, 300
pole3pos = x, y = 850, 300

#define the 6 blocks and size them
block1 = pygame.image.load('purple.png').convert_alpha()
block2 = pygame.image.load('blue.png').convert_alpha()
block3 = pygame.image.load('green.png').convert_alpha()
block4 = pygame.image.load('yellow.png').convert_alpha()
block5 = pygame.image.load('orange.png').convert_alpha()
block6 = pygame.image.load('red.png').convert_alpha()
block1 = pygame.transform.scale(block1, polesize)
block2 = pygame.transform.scale(block2, polesize)
block3 = pygame.transform.scale(block3, polesize)
block4 = pygame.transform.scale(block4, polesize)
block5 = pygame.transform.scale(block5, polesize)
block6 = pygame.transform.scale(block6, polesize)

#dict for values
blval = {block1 : 1, block2 : 2, block3 : 3, block4 : 4, block5 : 5, block6 : 6}

def reset():
    global pltb1, pltb2, pltb3, held, wpole, horiz, xpos, done, dela
    #pole starting tables
    pltb1 = [block1, block2, block3, block4, block5, block6]
    pltb2 = []
    pltb3 = []

    #define state variables
    held = ''
    wpole = [pltb1, pltb2, pltb3]
    horiz = 0
    xpos = [50, 450, 850]

    #for win purpose
    done = ' '

    #for auto check and delay in auto
    dela = ''

def refresh():#defining position of poles
    SCREEN.fill(black)
    SCREEN.blit(pole1, (pole1pos))
    SCREEN.blit(pole2, (pole2pos))
    SCREEN.blit(pole3, (pole3pos))
    if not dela:
        SCREEN.blit(wtext, (50, 20))
        SCREEN.blit(stext, (50, 40))
        SCREEN.blit(atext, (50, 60))
        SCREEN.blit(dtext, (50, 80))
    SCREEN.blit(rtext, (50, 100))
    pygame.draw.rect(SCREEN, white, (xpos[horiz] + 187, 200, 20, 20))
    length1 = len(wpole[0])
    length2 = len(wpole[1])
    length3 = len(wpole[2])
    if length1 != 0:
        for i in pltb1:
            SCREEN.blit(i, (50, 415 - pltb1.index(i) * 27 ))
    if length2 != 0:
        for i in pltb2:
            SCREEN.blit(i, (450, 415 - pltb2.index(i) * 27 ))
    if length3 != 0:
        for i in pltb3:
            SCREEN.blit(i, (850, 415 - pltb3.index(i) * 27 ))
    if held:
        SCREEN.blit(held, (xpos[horiz], 50))
    pygame.display.flip()

#refresh the screen



def main():
    global pltb2, dela
# Main game loop
    running = True
    refresh()
    key_pressed = {}  # Dictionary to track pressed keys

    while running:
    # Event handling
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_w and done and not dela:
                    if 'w' not in key_pressed:
                        key_pressed['w'] = True
                        up()
                elif event.key == pygame.K_s and done and not dela:
                    if 's' not in key_pressed:
                        key_pressed['s'] = True
                        down()
                elif event.key == pygame.K_d and done and not dela:
                    if 'd' not in key_pressed:
                        key_pressed['d'] = True
                        right()
                elif event.key == pygame.K_a and done and not dela:
                    if 'a' not in key_pressed:
                        key_pressed['a'] = True
                        left()
                elif event.key == pygame.K_r:
                    if 'r' not in key_pressed:
                        key_pressed['r'] = True
                        reset()
                        refresh()
                #testing the you win feature.
                elif event.key == pygame.K_0 and done and not dela:
                    if '0' not in key_pressed:
                        key_pressed['0'] = True
                        pltb2 = [block1, block2, block3, block4, block5, block6]
                #auto feature
                elif event.key == pygame.K_9 and done and not dela:
                    if '9' not in key_pressed:
                        key_pressed['9'] = True
                        reset()
                        dela = ' '
                        refresh()
                        auto()

            elif event.type == pygame.KEYUP:
                if event.key == pygame.K_w and done and not dela:
                    if 'w' in key_pressed:
                        del key_pressed['w']
                elif event.key == pygame.K_s and done and not dela:
                    if 's' in key_pressed:
                        del key_pressed['s']
                elif event.key == pygame.K_d and done and not dela:
                    if 'd' in key_pressed:
                        del key_pressed['d']
                elif event.key == pygame.K_a and done and not dela:
                    if 'a' in key_pressed:
                        del key_pressed['a']
                elif event.key == pygame.K_r:
                    if 'r' in key_pressed:
                        del key_pressed['r']
                elif event.key == pygame.K_0 and done and not dela:
                    if '0' in key_pressed:
                        del key_pressed['0']
                elif event.key == pygame.K_9 and done and not dela:
                    if '9' in key_pressed:
                        del key_pressed['9']
        if not dela:
            if len(pltb2) == 6 or len(pltb3) == 6:
                win()
    clock.tick(60)

# Quit Pygame
    pygame.quit()
    sys.exit()

def up():
    global held
    if dela:
        pygame.time.wait(wait1)
    if held:
        return
    else:
        length = len(wpole[horiz])
        if length == 0:
            return
        else:
            held = wpole[horiz].pop(-1)
            refresh()

def down():
    global held
    if dela:
        pygame.time.wait(wait1)
    if held:
        length = len(wpole[horiz])
        if length == 0:
            wpole[horiz].append(held)
            held = ''
            refresh()
            return
        else:
            if blval[held] > blval[wpole[horiz][-1]]:
                wpole[horiz].append(held)
                held = ''
                refresh()
                return
            else:
                return
    else:
        return

def right():
    global horiz
    if dela:
        pygame.time.wait(wait1)
    if horiz == 2:
        return
    horiz += 1
    refresh()

def left():
    global horiz
    if dela:
        pygame.time.wait(wait1)
    if horiz == 0:
        return
    horiz -= 1
    refresh()

def win():
    global done
    done = ''
    font = pygame.font.Font('freesansbold.ttf', 50)
    win = font.render('YOU WIN!!!', True, white)
    SCREEN.fill(black)
    SCREEN.blit(win, (1280 // 2 - 200, 720 // 2))
    font = pygame.font.Font('freesansbold.ttf', 20)
    SCREEN.blit(rtext, (50, 100))
    pygame.display.flip()

def auto():
    place1tor = [up, right, down]
    place1to2r = [up, right, right, down]
    place1tol = [up, left, down]
    place1to2l = [up, left, left, down]
    move1r = [right]
    move2r = [right, right]
    move1l = [left]
    move2l = [left, left]
    """auto = [up(), right(), down(),
    left(), up(), right(), right(), down(), 
    left(), up(), right(), down(), 
    left(), left(), up(), right(), down(), 
    right(), up(), left(), left(), down(), 
    right(), right(), up(), left(), down()]"""
    aut = [place1tor, move1l, place1to2r, move1l, place1tor, move2l, place1tor, move1r, place1to2l, move2r, place1tol]
    for i in aut:
        for x in i:
            x()
            refresh()

reset()   
main()