#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# Bash script to simulate the git work flow
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=/tmp/dev1
mkdir $dir

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
