#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# Bash script to simulate the git work flow
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=$(mktemp -d)

Dev_name="Kaakam Bird"
Dev_email="K.Bird@email.com"


cd $dir
# step 1: initialize git
git init
git config user.name $Dev_name
git config user.email $Dev_email

# create an empty README file
touch README.md

# create the version file with
echo "0.0.0" > version.txt
git add README.md version.txt
git commit -m "Add initial files"

#tag current version
git tag -a 0.0.0 -m "Initial README file"


#create develop branch
git checkout -b develop master


#step 2: Add todo list in README.md
echo "TODOs 1. Make templaets 2. Make hooks" >> README.md
git add README.md
git commit -m "Add TODOs to README.md"

# step #: push 
git remote add origin "/tmp/gitworkFlow"
git push origin master
git push origin develop
git push origin --tags

sleep 3


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
