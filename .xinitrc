#!/bin/sh

# export DRI_PRIME=1
# xorg
xrdb -merge ~/.Xresources &&
	xset s off -dpms
xset -b
xset r rate 300 50
xsetroot -cursor_name left_ptr

# systemd
. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# autostart
ibus-daemon -drxR
playerctld daemon &
hsetroot -full ~/files/pix/jpegpng/kiminonawa-mitsuha.jpg

# wm
dwm
