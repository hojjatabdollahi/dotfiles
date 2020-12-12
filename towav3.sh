#!/bin/bash
VIDBASEDIR=/media/hoji/SSD/SPINVideo/robot_captured/set4
AUDBASEDIR=/media/hoji/SSD/SPINVideo/robot_captured/set4/-4
FILES=$VIDBASEDIR/*.mpg
for i in $FILES
do
  echo "Processing $f file..."
  #ffmpeg -i $i -ar 44100 a.wav
  #ffmpeg -i a.wav -ar 16000 -ac 1 ${i%%.*}.wav
  
  #rm a.wav
  FILENAME=${i##*/}
  ffmpeg -i $i -i $AUDBASEDIR/${FILENAME%%.*}_left.wav -map 0:v -map 1:a -c copy -shortest ${i%%.*}_new.avi
done
