#!/bin/bash

curl -L --output light.deb https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb
dpkg --install light.deb
rm light.deb
usermod -a -G video $SUDO_USER
