#!/bin/bash
FILES=*.avi
for i in $FILES
do
  echo "Processing $f file..."
  ffmpeg -i $i -ar 44100 a.wav
  ffmpeg -i a.wav -ar 16000 -ac 1 ${i%%.*}.wav
  rm a.wav

  ffmpeg -i $i -i ${i%%.*}.wav -map 0:v -map 1:a -c copy -shortest ${i%%.*}_new.avi
done
