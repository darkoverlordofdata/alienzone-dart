#!/bin/bash
#
#   Pack into zip and copy to sdcard for CocoonJS Player
#
rm -f alienzone.zip
cd build/web
#
# squeeze some more space out
#
#vulcanize --strip --inline --csp --output alienzone.html index.html
#rm -f index.html
#mv -f alienzone.html index.html
#rm -f index.html_bootstrap.dart.js
#rm -fr js
#rm -fr packages/core_elements
#rm -fr packages/paper_elements
#
# zip it up
#
zip -r ../../alienzone.zip .
cd ..
cd ..
adb push alienzone.zip /sdcard/alienzone.zip
