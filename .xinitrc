#!/bin/sh

# X11 properties
xrdb -merge ~/.Xresources &&
xset s off -dpms
xset -b
xset r rate 300 50
xsetroot -cursor_name left_ptr

# systemd
. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# arrange screens
twoscr() {
    xrandr --output LVDS1 --mode 1366x768 --rate 60 --auto
    xrandr --output VGA1 --primary --mode 1280x1024 --rate 75 --auto --left-of LVDS1
}

onescr() {
    xrandr --output LVDS1 --primary --mode 1366x768 --rate 60 --auto
}

$(xrandr -q | grep -q "VGA1 connected") && twoscr || onescr

# autostart
ibus-daemon -drxR
playerctld daemon &
picom --experimental-backends &
hsetroot -cover ~/.local/share/wallpaper/normal.png

awesome
