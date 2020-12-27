#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# This is the 1st developer's 2nd script.
# It pulls from remote, adds a feature branch and hot_fix branch
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=/tmp/dev1


cd $dir


git fetch --all
git checkout develop
git merge origin/develop

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



git checkout -b hot_fix_1.0.1 master

sed -i 's/templaets/templates/g' README.md

git add README.md
git commit -m "Fix: correct typo"

echo "1.0.1" > version.txt
git add version.txt
git commit -m "Update version to 2.0.1"

git checkout master
git merge --no-ff hot_fix_1.0.1 -m "Merge branch 'hot_fix_1.0.1' into master"
git tag -a 1.0.1 -m "Fix typo"

git checkout develop
git merge --no-ff hot_fix_1.0.1 -m "Merge branch 'hot_fix_1.0.1' into develop"

git branch hot_fix_1.0.1 -d

git push --all
git push origin --tags

git checkout -b release_1.1.1 develop
# TEST release_1.1.0 branch

# step 12:
echo "1.1.1" > version.txt
git add version.txt
git commit -m "Update version to 1.1.1"



git checkout master

# step 14:
git merge --no-ff release_1.1.1 -m "Merge branch 'release_1.1.1. into master"
git tag -a 1.1.1 -m "Templates are ready"

# step 15:
git checkout develop
git merge --no-ff release_1.1.1 -m "Merge branch 'release_1.1.1' into develop"

git branch release_1.1.1 -d

git fetch --all
git checkout develop
git merge origin/develop

git checkout master
git merge origin/master

git push --all
git push origin --tags


gitk  --all &
