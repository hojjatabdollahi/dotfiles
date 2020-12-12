#!/bin/sh



FILES=*.mpg
for i in $FILES
do
  echo "Processing $f file..."
  #ffmpeg -i $i -acodec copy -vcodec copy ${i%%.*}.mpg
  #ffmpeg -i $i -ar 44100 a.wav  
  #ffmpeg -i a.wav -ar 16000 -ac 1 b.wav  
  #ffmpeg -i b.wav -map_channel 0.0.0 "${i%%.*}_left.wav"
  
  #rm a.wav
  #rm b.wav
  
  ffmpeg -i $i -i ${i%%.*}_left.wav -map 0:v -map 1:a -c copy -shortest ${i%%.*}_new.avi  


done
