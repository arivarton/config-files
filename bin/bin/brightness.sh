#! /usr/bin/env zsh

PRIMARY_OUTPUT=$(xrandr | grep -e '[^dis]connected primary' | cut -d ' ' -f 1)
BRIGHTNESS=$(xrandr --current --verbose | grep -i brightness | cut -d ' ' -f 2)

if [[ $1 = 'up' ]]
then
    if [[ $BRIGHTNESS = 1.0 ]]
    then
        echo 'Brighness is at max'
    else
        echo 'Increasing brightness'
        BRIGHTNESS=$(($BRIGHTNESS+0.05))
    fi
elif [[ $1 = 'down' ]]
then
    echo 'Decreasing brightness'
    BRIGHTNESS=$(($BRIGHTNESS-0.05))
else
    echo 'Need either up or down as argument'
fi

xrandr --output $PRIMARY_OUTPUT --brightness $BRIGHTNESS
