#!/bin/sh
#
#   Deploy gh-pages
#
cd ./build/
git clone git@github.com:darkoverlordofdata/alienzone-dart.git gh-pages
cd ./gh-pages/
git checkout gh-pages
git rm -rf .
cp -r ./.git ../web
cd ../web
git add . --all
git commit -m publish
git push origin gh-pages