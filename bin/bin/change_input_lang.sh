#! /usr/bin/env bash

VIDEO_OUTPUT=$(xrandr | grep -e '[^dis]connected primary' | cut -d ' ' -f 1)
if [ $VIDEO_OUTPUT == 'eDP-1' ]; then
    LANGUAGES=(gb is no)
else
    LANGUAGES=(us is no)
fi

CURRENT_LANGUAGE=$(setxkbmap -query | grep layout | cut -d ' ' -f 6)

declare -A LANGUAGES_DICT

index=0
for language in ${LANGUAGES[@]}; do
    LANGUAGES_DICT[$language]=$index
    echo "Adding $language to dictionary with index $index"
    ((index++))
done

change(){
    language_index=${LANGUAGES_DICT[$CURRENT_LANGUAGE]}
    ((language_index++))
    echo "Language index is $language_index"
    if ! [ ${LANGUAGES[$language_index]} ]; then
        language_index=0
    fi
    echo "Changing language to ${LANGUAGES[$language_index]}"
    setxkbmap ${LANGUAGES[$language_index]}
}

if [ $1 ]; then
    if [ $1 = 'change' ]; then
        change
    else
        echo 'Argument not known. Only "change" is recognized as an argument.'
    fi
else
    echo 'Specify "change" as an argument.'
fi
