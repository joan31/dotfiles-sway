#!/bin/sh

# Sway xdg-desktop-portal-wlr (WebRTC...)
export XDG_CURRENT_DESKTOP=sway

# SDL2 Wayland
#export SDL_VIDEODRIVER=wayland

# QT Wayland
#export QT_QPA_PLATFORM="wayland;xcb"
#export QT_QPA_PLATFORMTHEME=qt5ct
#export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

# Java Wayland
#export _JAVA_AWT_WM_NONREPARENTING=1
#export STUDIO_JDK=/usr/lib/jvm/java-11-openjdk-amd64/ /opt/android-studio/bin/studio.sh
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

# Firefox Wayland
export MOZ_ENABLE_WAYLAND=1
#export MOZ_WAYLAND_USE_VAAPI=1
export GTK_THEME=Adwaita:dark

# Default Applications
export TERM=alacritty
export BROWSER=firefox
export VISUAL=nvim
export EDITOR=nvim

# Start Sway
exec sway
