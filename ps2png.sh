#!/bin/bash
# convert a single-page ps file into png format using gs
# usage:
#            ps2png psfile.ps
# Note:
#           1: need gs installed
#           2: same name is used for the png file
#           http://scriptdemo.blogspot.com

if [ $# == 0 ]; then
   sed -n '2,4p' `which ps2png`
   exit
else
  for psname in $*
  do
     if [ -e $psname ]; then
        pngname=`echo ${psname%%.*}`
          gs -r300 -dTextAlphaBits=4 -dUseCropBox -sDEVICE=png16m -sOutputFile=${pngname}.png -dBATCH -dNOPAUSE ${psname}
     else
        echo "${psname} does not exist!"
     fi
  done
fi
