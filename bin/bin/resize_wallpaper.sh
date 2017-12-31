#! /usr/bin/env bash

WALLPAPER=$(cat .xinitrc | grep -E "^WALLPAPER=.*$" | cut -d '=' -f 2 | sed "s|\~|$HOME|")
STANDARD_WALLPAPER_PATH=$(cat .xinitrc | grep -E "STANDARD_WALLPAPER_PATH=.*$" | cut -d '=' -f 2 | sed "s|\~|$HOME|")

resize() {
    primary_resolution=$(xrandr | grep primary | awk '{print $4}' | sed 's/+0//g')
    wallpaper_size=$(file $STANDARD_WALLPAPER_PATH | awk '{print $5 $6 $7}' | sed 's/,//g')
    if [[ $primary_resolution != $wallpaper_size ]]; then
        convert $WALLPAPER -resize $primary_resolution\! $STANDARD_WALLPAPER_PATH
    fi
    echo $STANDARD_WALLPAPER_PATH
}

set() {
    feh --bg-fill $(resize) 
}

if [[ $2 ]]; then
    echo 'Too many arguments. Only one is required'
elif [[ $1 == 'resize' ]]; then
    resize
elif [[ $1 == 'set' ]]; then
    set
else
    echo 'Arguments expected are either "resize" or "set"'
fi
