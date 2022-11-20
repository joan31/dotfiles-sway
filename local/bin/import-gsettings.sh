#!/bin/sh

# usage: import-gsettings
config="${XDG_CONFIG_HOME:-$HOME/.conifg}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
#gtk_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
#gtk_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
#gtk_theme="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"

gsettings set "$gnome_schema" color-scheme prefer-dark

gsettings set "$gnome_schema" gtk-scheme "$gtk_theme"
#gsettings set "$gnome_schema" icon-scheme "$icon_theme"
#gsettings set "$gnome_schema" cursor-scheme "$cursor_theme"
#gsettings set "$gnome_schema" font-name "$font_name"
