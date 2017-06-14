# Set keymap to gb
setxkbmap gb

# Refresh xrdb
xrdb -merge ~/.Xresources

# Identify the id of laptop touchpad 
id=$(xinput | grep TouchPad | awk {'print $6'} | awk -F'=' {'print $2'})
# Enable tap of touchpad
xinput set-prop $id 274 1

# Remove mouse when using keyboard
xbanish &

# Change hue and brightness of monitor depending on daylight
redshift -b 1.0:0.5 -l 65.68316833109415:-18.138427734375 -t 6500:2500 &

# Make the HDMI output autodetect at startup
xrandr --output HDMI-2 --auto --above eDP-1 --noprimary

# Set background picture
feh --bg-fill Pictures/Wallpapers/SDO_Year6_HCblend_8k_small.png

# Start spideroak
SpiderOakONE &

# Start gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Execute i3 window manager
exec i3 -V >> ~/.logs/i3/$(date +'%F-%k-%M-%S').log 2>&1
