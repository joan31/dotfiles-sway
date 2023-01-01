#!/bin/env bash
# Usage:
# ./sway_lock.sh

# Init Variables
IMAGE=""
REMOVE_IMAGES=""
LOCK_ARGS=""

# Items
# Font
FONT_NAME="SF-Pro-Display-Regular"
FONT_SIZE="32"
FONT_COLOR="#cdd6f4"
# Message
LOCK_MESSAGE="Type password to unlock"
MESSAGE_POSITION="center"
MESSAGE_COORDINATES="+0-200"
# Picture
LOCK_PICTURE="$HOME/.config/sway/scripts/sway_lock.png"
PICTURE_POSITION="center"

# Effects
# Filter
FILTER_TYPE="Gaussian"
FILTER_VALUE="20%"
# Blur
# Options: http://www.imagemagick.org/Usage/blur/#blur_args
BLUR_TYPE="0x5"
BLUR_VALUE="500%"

if ! pgrep -x swaylock >/dev/null
then
	for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
	do
		IMAGE=/tmp/"$OUTPUT"-lock.png

		grim -o "$OUTPUT" "$IMAGE"

		convert "$IMAGE" -filter "$FILTER_TYPE" -resize "$FILTER_VALUE" \
		-blur "$BLUR_TYPE" -resize "$BLUR_VALUE" \
		-font "$FONT_NAME" -pointsize "$FONT_SIZE" -fill "$FONT_COLOR" \
		-gravity "$MESSAGE_POSITION" -annotate "$MESSAGE_COORDINATES" "$LOCK_MESSAGE" - | \
		composite -gravity "$PICTURE_POSITION" "$LOCK_PICTURE" - "$IMAGE"

		LOCK_ARGS="${LOCK_ARGS} --image ${OUTPUT}:${IMAGE}"
		REMOVE_IMAGES="${REMOVE_IMAGES} ${IMAGE}"
	done

	swaylock -f $LOCK_ARGS

	rm $REMOVE_IMAGES

	exit 0
else
	echo "Process swaylock already running..."
	exit 1
fi
