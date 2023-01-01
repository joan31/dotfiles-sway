#!/usr/bin/env bash
filename="${HOME}/Pictures/Screenshots/$(date +'%Y%m%d_%H%m%S')_area.png"
summary="Screenshot area saved"
touch $filename
grim -g "$(slurp)" $filename | grim - | wl-copy
notify-send -i $filename "$summary" $filename
