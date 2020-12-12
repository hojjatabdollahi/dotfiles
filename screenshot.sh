#!/bin/sh
DATE=`date +%Y-%m-%d_%H:%M:%S`
PLACE=/home/hojjat/Dropbox/Screenshots/linux/
scrot $PLACE/$DATE.png
optipng $PLACE/$DATE.png