#!/bin/bash

[[ ! -d /etc/X11/xorg.conf.d ]] && mkdir /etc/X11/xorg.conf.d

#touch /etc/x11/xorg.conf.d/90-touchpad.conf

cat <<EOF > /etc/X11/xorg.conf.d/90-touchpad.conf
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
EndSection
EOF
