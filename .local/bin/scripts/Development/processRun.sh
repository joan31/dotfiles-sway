#!/bin/env bash
PROCESS=waybar

if pgrep -x "$PROCESS" >/dev/null
then
	echo "$PROCESS running"
else
	echo "$PROCESS stopped"
fi

if ! pgrep -x "$PROCESS" >/dev/null
then
	echo "$PROCESS stopped"
	exit 1
else
	echo "$PROCESS running"
	exit 0
fi
