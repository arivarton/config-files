# Common variables
WALLPAPER=~/Pictures/Gimp/eldfjoll.png
STANDARD_WALLPAPER_PATH=~/Pictures/Wallpapers/current_wallpaper.png

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
redshift -b 1.0:0.8 -t 6500:3000 &

# Start spideroak
SpiderOakONE &

# Start gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Turn of laptop display if monitor is connected
if [ -n "$(xrandr | grep 'HDMI-2 connected')" ]; then
    xrandr --output eDP-1 --off
    xrandr --output HDMI-2 --primary
fi

# Set wallpaper
feh --bg-fill resize_wallpaper.sh


# Execute i3 window manager
exec i3 -V >> ~/.logs/i3/$(date +'%F-%k-%M-%S').log 2>&1
