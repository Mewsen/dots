#!/usr/bin/env bash


resolution=$(hyprctl monitors | grep "3840x2160.*0x0")

if [[ $resolution == *"3840x2160"* ]]; then
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
    gsettings set org.gnome.desktop.interface scaling-factor 1.5
else
    gsettings set org.gnome.desktop.interface text-scaling-factor 1
    gsettings set org.gnome.desktop.interface scaling-factor 1
fi

