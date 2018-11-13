#! /usr/bin/env bash

PRIMARY_OUTPUT=$(xrandr | grep -e '[^dis]connected primary' | cut -d ' ' -f 1)
ALTERNATIVE_OUTPUT=$(xrandr | grep -e '[^dis]connected [^primary]' | cut -d ' ' -f 1)

change(){
    # Only run if alternative output is present, if not turn on primary output.
    if [ $ALTERNATIVE_OUTPUT ]; then
        xrandr --output $PRIMARY_OUTPUT --off
        xrandr --output $ALTERNATIVE_OUTPUT --primary --auto
    else
        xrandr --output $PRIMARY_OUTPUT --primary --auto
    fi
    resize_wallpaper.sh set
}

mirror(){
    # Only run if alternative output is present.
    if [ $ALTERNATIVE_OUTPUT ]; then
        xrandr --output $ALTERNATIVE_OUTPUT --auto
    fi
}

if [ $1 ]; then
    if [ $1 = 'change' ]; then
        change
    elif [ $1 = 'mirror' ]; then
        mirror
    else
        echo 'Argument not known. Specify either "change" or "mirror" as arguments.'
    fi
else
    echo 'Specify either "change" or "mirror" as arguments'
fi
