#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
#         File: gitWorkFlow.sh
#               Bash script to simulate the git work flow
#   Created by: vikgna
#   Created on: 2020/01/16
#  Modified by: vikgna
#  Modified on: 2020/01/16
#      Version: 1.0
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

#git init

echo "#############################" > file.txt
echo "# Version: 1.0" >> file.txt
echo "#############################" >> file.txt
echo "This is a sample file." >> file.txt

git init
git add file.txt
git commit -m "Add file.txt"
git tag -a 1.0 -m "Tag 1.0"

git checkout -b develop master

echo "A new line is added." >> file.txt
git add -u
git commit -m "Add a line"

git checkout -b edit develop
sed -i 's/sample file/simple text file/g' file.txt
git add -u
git commit -m "Edit a line"

git checkout develop

echo "Hey time to relaese." >> file.txt
git add -u
git commit -m "Add another line"

git checkout -b release_2.0 develop
sed -i 's/Version: 1.0/Version: 2.0/g' file.txt
git add -u
git commit -m "Update version to 2.0"

git checkout master

git merge --no-ff release_2.0
git tag -a 2.0 -m "Tag 2.0"

git checkout develop

git merge --no-ff release_2.0
git branch -d release_2.0

git merge --no-ff edit
git branch -d edit

#git push origin develop

git checkout -b hotfix_2.0.1 master

sed -i 's/Version: 2.0/Version: 2.0.1/g' file.txt
git add -u
git commit -m "Update version to 2.0.1"

sed -i 's/relaese/release/g' file.txt
git add -u
git commit -m "Fix the spelling error"

git checkout master

git merge --no-ff hotfix_2.0.1
git tag -a 0.1.1 -m "Tag 2.0.1"

git checkout develop

git merge --no-ff hotfix_2.0.1

git branch -d hotfix_2.0.1 
