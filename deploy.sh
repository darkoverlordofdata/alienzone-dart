git clone git@github.com:darkoverlordofdata/alienzone.git gh-pages
cd gh-pages
git checkout gh-pages
git rm -rf .
...
cd ../web
git add . --all
git commit -m publish
git push origin gh-pages