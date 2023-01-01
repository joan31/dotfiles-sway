#!/usr/bin/env bash
# Usage:
# ./control_volume.sh mute
# ./control_volume.sh raise <value>
# ./control_volume.sh lower <value> 

# Global variables
KEY="$1"
VOLUME="$2"
MAX_VOLUME="100"
SINK_INDEX="0"

# Critera notification app-name define in mako config
NOTIF_APPNAME="control_volume"

MUTED_ICON=""
LOW_ICON=""
MEDIUM_ICON=""
HIGH_ICON=""

# Function to mute/unmute
muteVolume () {
	pactl set-sink-mute "$SINK_INDEX" toggle
}

# Function to unmute when raise/lower volume
unmuteVolume () {
	local volumeStatus="$(pactl get-sink-mute "$SINK_INDEX" | awk '{print $2}')"

	if [[ "$volumeStatus" == yes ]]
	then
		pactl set-sink-mute "$SINK_INDEX" false
	fi
}

# Function to raise volume
raiseVolume () {
	# Set variables volume for each outputs
	local setVolumeLeft="$VOLUME"
	local setVolumeRight="$VOLUME"

	# Get level volume from left and right outputs
	local levelVolumeLeft="$(pactl get-sink-volume "$SINK_INDEX" | grep Volume | awk '{print $5}' | tr -d '%')"
	local levelVolumeRight="$(pactl get-sink-volume "$SINK_INDEX" | grep Volume | awk '{print $12}' | tr -d '%')"
	
	# Raise left output if needed
	if [[ "$levelVolumeLeft" -lt "$MAX_VOLUME" ]]
	then
		# Volume offset to avoid exceeding the max volume	
		local offsetVolumeLeft="$(("$MAX_VOLUME"-"$levelVolumeLeft"))"
		[[ "$setVolumeLeft" -gt "$offsetVolumeLeft" ]] && setVolumeLeft="$offsetVolumeLeft"	
		
		pactl set-sink-volume "$SINK_INDEX" +"$setVolumeLeft"% +0%
	fi

	# Raise right output if needed
	if [[ "$levelVolumeRight" -lt "$MAX_VOLUME" ]]
	then
		# Volume offset to avoid exceeding the max volume
		local offsetVolumeRight="$(("$MAX_VOLUME"-"$levelVolumeRight"))"
		[[ "$setVolumeRight" -gt "$offsetVolumeRight" ]] && setVolumeRight="$offsetVolumeRight"
		
		pactl set-sink-volume "$SINK_INDEX" +0% +"$setVolumeRight"%
	fi
}

# Function to lower volume
lowerVolume () {
	pactl set-sink-volume "$SINK_INDEX" -"$VOLUME"%
}

# Function to display popup with volume status
popupStatus () {
	local volumeStatus="$(pactl get-sink-mute "$SINK_INDEX" | awk '{print $2}')"
	
	if [[ "$volumeStatus" == yes ]]
	then
		notify-send -a "$NOTIF_APPNAME" ""$MUTED_ICON"  Muted"
	else
		# Determine if volume on each outputs is not different
		# Boolean operator (1 if expr is equal 0): echo "! expr" | bc
		local balance="$(echo "! "$(pactl get-sink-volume "$SINK_INDEX" | grep balance | awk '{print $2}' | sed 's/,/\./')"" | bc)"
		
		if [[ "$balance" -eq 1 ]]
		then
			local levelVolumeGlobal="$(pactl get-sink-volume "$SINK_INDEX" | grep Volume | awk '{print $5}' | tr -d '%')"
			local iconVolumeGlobal="$(setIconVolume "$levelVolumeGlobal")"
			
			notify-send -a "$NOTIF_APPNAME" ""$iconVolumeGlobal"  "$levelVolumeGlobal"%"
		else
			local levelVolumeLeft="$(pactl get-sink-volume "$SINK_INDEX" | grep Volume | awk '{print $5}' | tr -d '%')"
			local levelVolumeRight="$(pactl get-sink-volume "$SINK_INDEX" | grep Volume | awk '{print $12}' | tr -d '%')"
			local iconVolumeLeft="$(setIconVolume "$levelVolumeLeft")"
			local iconVolumeRight="$(setIconVolume "$levelVolumeRight")"
			
			notify-send -a "$NOTIF_APPNAME" ""$iconVolumeLeft"  "$levelVolumeLeft"% / "$iconVolumeRight"  "$levelVolumeRight"%"
		fi
	fi
}

# Function to set the right state of the volume icon
setIconVolume () {
	local valueVolume="$1"
	local iconVolume
	
	# Low 0-32 / Medium 33-65 / High *
	case "$valueVolume" in
		[0-9]|1[0-9]|2[0-9]|3[0-2]) iconVolume="$LOW_ICON" ;;
		3[3-9]|4[0-9]|5[0-9]|6[0-5]) iconVolume="$MEDIUM_ICON" ;;
		*) iconVolume="$HIGH_ICON" ;;
	esac
	echo "$iconVolume"
}

# Main
case "$KEY" in
	mute)
		muteVolume
		popupStatus
		;;
	raise)
		unmuteVolume
		raiseVolume
		popupStatus
		;;
	lower)
		unmuteVolume
		lowerVolume
		popupStatus
		;;
esac
