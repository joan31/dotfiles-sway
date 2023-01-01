#!/usr/bin/env bash
filename="${HOME}/Images/Screenshots/$(date +'%Y%m%d_%H%m%S')_monitor.png"
summary="Screenshot monitor saved"
touch $filename
grim $filename | grim - | wl-copy
notify-send -i $filename "$summary" $filename
