#! /usr/bin/env bash

STANDARD_WALLPAPER_PATH=$(cat .xinitrc | grep -E "STANDARD_WALLPAPER_PATH=.*$" | cut -d '=' -f 2 | sed "s|\~|$HOME|")

change() {
    sed -i "s|WALLPAPER=.*|WALLPAPER=$1|" ~/.xinitrc
    convert $1 $STANDARD_WALLPAPER_PATH
    feh --bg-fill $(resize_wallpaper.sh resize)
}

if [ $2 ]; then
    echo 'Too many arguments. Only wallpaper path is required.'
elif [ $1 ]; then
    change $1
else
    echo 'Specify path to wallpaper as argument.'
fi
