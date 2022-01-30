#!/usr/bin/env bash

eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
export SSH_AUTH_SOCK

for f in /etc/X11/xinit/xinitrc.d/*.sh ; do
    "$f"
done
    unset f

#/bin/xcalib -d :0 ~/.config/dell_u2417hj.icc

xset +fp /usr/share/fonts/local
xset +fp /home/ox/.fonts
xset fp rehash
xrdb -load ~/.Xresources &
xset -b &

xsetroot -cursor_name left_ptr &
hsetroot -center ~/Downloads/wallhaven-567719.jpg
~/.config/lemonbar/citrus.sh &
#compton --config ~/.compton.conf &
battery_alert.sh &
sxhkd -c ~/.config/sxhkd/sxhkdrc -r .sxlog & #& > .sxhkdlog 2>&1 &
exec bspwm -c ~/.config/bspwm/bspwmrc #> .xinit.log 2>&1
