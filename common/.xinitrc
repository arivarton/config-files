# Common variables
wallpaper=~/Pictures/Gimp/Laekur.png

# Set keymap to gb
setxkbmap -option caps:escape

# Refresh xrdb
xrdb -merge ~/.Xresources

# Identify the id and property of laptop touchpad 
touchpad_id=$(xinput | grep TouchPad | awk {'print $6'} | awk -F'=' {'print $2'})
touchpad_property=$(xinput list-props $touchpad_id | grep 'Tapping Enabled (' | sed 's/^.*Tapping Enabled (\([0-9]*\)).*$/\1/')
# Enable tap of touchpad
xinput set-prop $touchpad_id $touchpad_property 1

# Remove mouse when using keyboard
xbanish &

# Change hue and brightness of monitor depending on daylight
redshift -b 1.0:0.5 -l 65.68316833109415:-18.138427734375 -t 6500:2500 &

# Start spideroak
SpiderOakONE &

# Start gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Turn of laptop display if monitor is connected
if [ -n "$(xrandr | grep 'HDMI-2 connected')" ]; then
    xrandr --output eDP-1 --off
    xrandr --output HDMI-2 --primary
fi

# Convert wallpaper to correct size
current_wallpaper_path=~/Pictures/Wallpapers/current_wallpaper.png
primary_resolution=$(xrandr | grep primary | awk '{print $4}' | sed 's/+0//g')
wallpaper_size=$(file $current_wallpaper_path | awk '{print $5 $6 $7}' | sed 's/,//g')
if [ $primary_resolution != $wallpaper_size ]; then
    convert $wallpaper -resize $primary_resolution\! $current_wallpaper_path
fi

# Set background picture
feh --bg-fill $current_wallpaper


# Execute i3 window manager
exec i3 -V >> ~/.logs/i3/$(date +'%F-%k-%M-%S').log 2>&1
