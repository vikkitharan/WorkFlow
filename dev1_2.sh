#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# Bash script to simulate the git work flow
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=/tmp/dev1


cd $dir



git fetch origin master
git fetch origin develop
git fetch --tags


git merge origin/develop develop

git checkout master
git merge origin/master

git checkout -b write_templates develop

mkdir templates
echo "commit message">  templates/commit.txt
git add templates/commit.txt
git commit -m "Add commit templates"

git checkout develop
git merge write_templates --no-ff -m "Merge branch 'write_templates' into develop"

git branch write_templates -d



git checkout -b hot_fix_1.0.0 master

sed -i 's/templaets/templates/g' README.md

git add README.md
git commit -m "Fix: correct typo"

echo "1.0.1" > version.txt
git add version.txt
git commit -m "Update version to 1.0.1"

git checkout master
git merge --no-ff hot_fix_1.0.0 -m "Merge branch 'hot_fix_1.0.0' into master"
git tag -a 1.0.1 -m "Fix typo"

git checkout develop
git merge --no-ff hot_fix_1.0.0 -m "Merge branch 'hot_fix_1.0.0' into develop"

git branch hot_fix_1.0.0 -d

git push origin master
git push origin develop
git push origin --tags

gitk  --all
rm $dir -rf
