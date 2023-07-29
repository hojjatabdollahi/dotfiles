#!/bin/bash


#### ON A NEW MACHINE
# install imagemagick
# and add   <policy domain="coder" rights="read | write" pattern="PDF" />
# to /etc/ImageMagick-7/policy.xml



mkdir -p tmp
cd png
FILES=*.png
for i in $FILES
do
  echo "Processing $i file..."
  # Needed to tell image magick that colorspace is RGB otherwise it kept nagging about Grayscale photos
  convert -colorspace RGB -define colorspace:auto-grayscale=false -define png:color-type=6  $i -quality 50 -resize 1275x1650 ../tmp/$i
done
cd ../tmp
convert *.png ../output-highres.pdf
cd ..
rm -r tmp

### If you need to get a different resolution use one of these
    # -dPDFSETTINGS=/screen lower quality, smaller size. (72 dpi)
    # -dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs. (150 dpi)
    # -dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting (300 dpi)
    # -dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting (300 dpi)
    # -dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file


/usr/bin/gs -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -q -o output-lowres.pdf output-highres.pdf
