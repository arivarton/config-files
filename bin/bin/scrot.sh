#!/bin/bash

scrot '%Y-%m-%d_%T.png' -e 'mv $f ~/Pictures/print_screens/' -s >> ~/.logs/print_screen_button.log
