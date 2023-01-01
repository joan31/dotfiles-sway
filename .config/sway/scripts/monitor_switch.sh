#!/usr/bin/env bash
# Usage:
# ./monitor_switch.sh monitorRight <$wss#>
# ./monitor_switch.sh monitorLeft <$wss#>

# Global variables
MONITOR="$1"
WORKSPACE="$2"

# Criteria notification app-name define in mako config
NOTIF_APPNAME="ws_switch_"$MONITOR""

notify-send -a "$NOTIF_APPNAME" "$WORKSPACE"
