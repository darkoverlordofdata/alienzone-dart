#!/bin/bash
#
#   Pack into zip and copy to sdcard for CocoonJS Player
#
cd build/web
zip -r ../../alienzone.zip .
cd ..
cd ..
adb push alienzone.zip /sdcard/alienzone.zip
