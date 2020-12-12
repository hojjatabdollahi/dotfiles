#!/bin/sh
for i in *.MP4;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  #ffmpeg -i "$i" "${name}.mov";
  ffmpeg -i "$i" -vf scale=-1:720 -c:v libx264 -crf 18 -preset veryslow -c:a copy "${name}.MKV"

done
