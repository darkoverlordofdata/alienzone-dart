#!/bin/bash
#
#   Pack into zip and copy to sdcard for CocoonJS Player
#
rm -f alienzone.zip
cd build/web

vulcanize -s  --inline --csp --output bootstrap.html index.html
rm -f index.html
mv -f bootstrap.html index.html
rm -fr js

rm -fr app/packages
mv -f packages app/packages
#
# zip it up
#
zip -r ../../alienzone.zip .
cd ..
cd ..
adb push alienzone.zip /sdcard/alienzone.zip
