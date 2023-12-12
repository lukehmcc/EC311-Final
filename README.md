﻿# EC311-Final - Wizard Skate



## Summary:

This is an FPGA project that is effectively dino run but with a new coat of paint. 

## Features:

- Infinite skating
- VGA output 
- Score counting (non-persistent)
- Jump and crouch
- Randomized obstacles
- Full color output
- Unique sprites for all character states (jumping, skating, crouching, etc)

## How to run:

### Prerecs:

- Own Xilinx Artix-7 FPGA
- VGA compatible dispaly out
- USB-A compbatible keyboard
- Have Vivado 2022.2 downloaded

### Running:

- Clone repo: `git clone https://github.com/lukehmcc/EC311-Final.git`
- Open project (located at `dino-game/dino-game.xpr`) in Vivado. 
- Generate bitstream for project & push to FPGA.
- Plug in keyboard and display.
- Enjoy!

## Contributors:

- Angel Amaya
- Naeel Quasem
- Roger Brown
- Luke McCarthy

## Code Overview
-Keyboard 
Interprets and debounces PS2 input for keyboard. Adapted from https://github.com/Digilent/Nexys-A7-100T-Keyboard.
-RNG
Generates pseudorandom numbers randomized with user input. 
-Fireball Controller
Uses random number generator to choose fireball orientations. Increments x and y offsets for fireballs.
-Jump Controller
Takes input from keyboard to generate y offsets for wizard jumping 
-VGA controller
Controls all VGA output. Sprites based on bitmaps. Sprite locations based on x & y offsets passed from Fireball and Jump. 
-Collision Control
Calculates if the wizard is touching a fireball based on x & y offsets.
-Score Keeping
Keeps score.
