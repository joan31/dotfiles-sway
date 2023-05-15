#!/bin/sh
# Add to $HOME/.zshrc
# alias ssway=".local/bin/ssway.sh"

# Sway xdg-desktop-portal-wlr (WebRTC...)
export XDG_CURRENT_DESKTOP="sway"
export XDG_SESSION_DESKTOP="sway"

# AMD Hardware video acceleration VA-API and VDPAU
export LIBVA_DRIVER_NAME="radeonsi"
export VDPAU_DRIVER="radeonsi"

# Set default VK driver
export AMD_VULKAN_ICD="RADV"
export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1="1"
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json"

# Config folder
export XDG_CONFIG_HOME="${HOME}/.config"

# User binaries folder
export PATH="${HOME}/.local/bin:${PATH}"

# Cursor theme
export XCURSOR_PATH="/usr/share/icons"
export XCURSOR_PATH="${XCURSOR_PATH}:${HOME}/.local/share/icons:${HOME}/.icons"
export XCURSOR_THEME="Catppuccin-Mocha-Lavender-Cursors"
export XCURSOR_SIZE="32"

# GTK
# PORTAL option needed to use thunar file browser by default on apps
#export GTK_THEME="Adwaita:dark"
export GTK_THEME="Catppuccin-Mocha-Standard-Blue-Dark:dark"
export GTK_USE_PORTAL="1"

# QT
export QT_QPA_PLATFORM="wayland-egl;xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_WAYLAND_FORCE_DPI="physical"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

# Clutter
export CLUTTER_BACKEND="wayland"

# SDL2
export SDL_VIDEODRIVER="wayland"

# Elementary/EFL
export ELM_DISPLAY="wl"
export ECORE_EVAS_ENGINE="wayland_egl"
export ELM_ENGINE="wayland_egl"
export ELM_ACCEL="opengl"

# Winit
export WINIT_UNIX_BACKEND="wayland"

# Java
export _JAVA_AWT_WM_NONREPARENTING="1"

# Firefox
export MOZ_ENABLE_WAYLAND="1"
export MOZ_WAYLAND_USE_VAAPI="1"

# Avoid gnome applications warnings for dbus accessibility
export NO_AT_BRIDGE="1"

# Default applications
export TERM="footclient"
export BROWSER="firefox"
export VISUAL="nvim"
export EDITOR="nvim"

# Start Sway
exec sway
