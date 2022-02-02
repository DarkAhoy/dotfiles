#!/bin/bash

curl -L --output "fonts.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

if [[ ! -d $HOME/.fonts ]]; then
   mkdir $HOME/.fonts
fi

mv fonts.zip $HOME/.fonts
pushd $HOME/.fonts
unzip fonts.zip
fc-cache -fv
rm fonts.zip
popd
