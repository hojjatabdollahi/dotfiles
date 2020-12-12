#!/bin/bash

FILES=*.mpg
for i in $FILES
do
  echo "Processing $i file..."
  #number=${i:3:3}
  let "number=${i%%.*}"
  let "decimal = 0"
  if [ $number -gt 50 ]
  then
    let "number = $number - 50"
    mv $i "../4/$number.mpg"
  fi

done
