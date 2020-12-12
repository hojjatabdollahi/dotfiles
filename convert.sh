#!/bin/sh
mkdir outputs
for f in *.mp3; do ffmpeg -i "$f" -c:a libmp3lame "outputs/${f%.mp3}.mp3"; done
