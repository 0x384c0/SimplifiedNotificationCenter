#merge with master
set -e
git checkout master
git merge dev -m "Merged branch dev"
git checkout dev
#push
git push origin master dev