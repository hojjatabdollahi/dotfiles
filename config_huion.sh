#!/bin/bash
#coding:utf8



#   # The udev rule: /etc/udev/rules.d/10-local_i2c_group.rules
#	# "idVendor" and "idProduct" were derived from the output of the lsusb command. or `sudo dmesg`
# ACTION=="add" \
# , SUBSYSTEM=="input" \
# , KERNEL=="mouse*" \
# , ATTRS{idVendor}=="256c" \
# , ATTRS{idProduct}=="006d" \
# , RUN+="/bin/sh -c ' /home/hojjat/Projects/dotfiles/config_huion.sh >> /home/hojjat/Projects/dotfiles/config_huion.log  2>&1'"




echo "`date '+%Y-%m-%dT%H:%M:%S'`, ShellPID $$, start"

# get the following values from `env` command
export DISPLAY=:1
export XAUTHORITY=/run/user/1000/gdm/Xauthority


sleep 1

if xsetwacom --list devices | grep -q "HUION Huion Tablet Pad pad"
then

	main_screen="HEAD-0" # Use HEAD instead of HDMI-0. So the first screen is HEAD-0
	bezier_args="0 20 80 100"
	positioning_mode="Absolute"
	raw_sample_lvl="9"
	suppress_lvl="10"

	# Maps the graphics tablet to the area of a specified screen (for multiple-screen environments).
	#xsetwacom set "HUION Huion Tablet Touch Strip pad" MapToOutput "$main_screen"
	xsetwacom set "HUION Huion Tablet Pen stylus" MapToOutput "$main_screen"
	xsetwacom set "HUION Huion Tablet Pad pad" MapToOutput "$main_screen"

	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 1 "key +ctrl +z -z -ctrl"
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 2 "key e" # toggle eraser mode
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 3 "key b" # brush tool
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 8 "key +shift +ctrl = -ctrl -shift"
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 9 "key +ctrl - -ctrl"
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 10 "key +ctrl d -ctrl"
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 11 "key shift" # hold shift and move cursor to change brush size
	xsetwacom --set 'HUION Huion Tablet Pad pad' Button 12 "key +ctrl p -ctrl" # changed the keybind, to be able to change to pan tool













	## The below value was gathered using xrandr and xinput to determine the monitor as well as which
	## number the HUION PenTablet Pen stylus device **id** listed as.
	##    ↳ HUION PenTablet Pen stylus                 id=15   [slave  pointer  (2)]
#
#	#stylus=$(xinput --list --short | grep HUION | grep stylus | awk '{ print $8 }' | grep -o -E '[0-9]+') # this uses awk
#	stylus=$(xinput --list --short | grep HUION | grep stylus | grep -oE 'id=[0-9]+' | grep -oE '[0-9]+' ) # this uses grep, which might be better, since I don't need to count how many columns are before it.
#	xinput map-to-output $stylus HDMI-1


else
	echo "No 'Tablet'"
fi
echo "`date '+%Y-%m-%dT%H:%M:%S'`, ShellPID $$, end"
echo -e "---\n"

exit 0

