#!/bin/bash

touchpadname=$(xinput --list --name-only | grep ELAN | grep Touchpad)

echo "Restarting Touchpad just in case"
export DISPLAY=":1"
xinput disable "${touchpadname}"
xinput enable  "${touchpadname}"


