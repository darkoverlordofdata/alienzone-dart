#!/bin/bash
#
#   Pack into zip and copy to sdcard for CocoonJS Player
#
rm -f alienzone.zip

#
#   switch to the game app
#
cd build/web/app
#
#   directly load the javascript
#
sed -i 's/<script type="text\/javascript"  src="packages\/browser\/dart.js"><\/script>//' index.html
sed -i 's/<script type="application\/dart" src="main.dart"><\/script>/<script src="main.dart.js"><\/script>/' index.html
#
#   compress it some more
#
vulcanize --strip --inline --csp --output alienzone.html index.html
rm -f index.html
mv -f alienzone.html index.html
rm -f main.dart.js
rm -fr js

#
#   switch to the bootstraper
#
cd ..
#
#   compress it some more
#
vulcanize --strip --inline --csp --output bootstrap.html index.html
rm -f index.html
mv -f bootstrap.html index.html
rm -fr js
rm -fr src

#
#   clean up the dart dependencies
#
rm -fr app/packages
rm -fr packages/browser
mv -f packages app/packages

#
#   zip it up
#
zip -r ../../alienzone.zip .
cd ..
cd ..

#
#   and copy to the device for testing
#
adb push alienzone.zip /sdcard/alienzone.zip
