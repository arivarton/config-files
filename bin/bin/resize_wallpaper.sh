#! /usr/bin/env bash

WALLPAPER=$(cat .xinitrc | grep -E "^WALLPAPER=.*$" | cut -d '=' -f 2 | sed "s|\~|$HOME|")
STANDARD_WALLPAPER_PATH=$(cat .xinitrc | grep -E "STANDARD_WALLPAPER_PATH=.*$" | cut -d '=' -f 2 | sed "s|\~|$HOME|")

resize() {
    primary_resolution=$(xrandr | grep primary | awk '{print $4}' | sed 's/+0//g')
    wallpaper_size=$(file $STANDARD_WALLPAPER_PATH | awk '{print $5 $6 $7}' | sed 's/,//g')
    if [ $primary_resolution != $wallpaper_size ]; then
        convert $WALLPAPER -resize $primary_resolution\! $STANDARD_WALLPAPER_PATH
    fi
    echo $STANDARD_WALLPAPER_PATH
}

if [ $1 ]; then
    echo 'No arguments required. Wallpaper path should be specified in .xinitrc or changed by using change_wallpaper.sh.'
else
    resize
fi
