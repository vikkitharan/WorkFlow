#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# Bash script to simulate the git work flow
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
member1=$(mktemp -d)
origin_dir=$(mktemp -d)

cd $origin_dir
git init --bare

echo $origin_dir
cd -

cd $member1
# initialize git
git init
# create an empty README file
touch README.md
# create the version file with
echo "0.0.0" > version.txt
git add README.md version.txt
#commit
git commit -m "Add initial files"
#tag current version
git tag -a 0.0.0 -m "Initial README file"

git remote add origin $origin_dir

git remote -v


create develop branch
git checkout -b develop master


#Add todo list in README.md
echo "TODOs 1. Make templaets 2. Make hooks" >> README.md
git add README.md
git commit -m "Add TODOs to README.md"

git checkout -b write_templates develop
mkdir templates
echo "commit message">  templates/commit.txt
git add templates/commit.txt
git commit -m "Add commit templates"

git checkout -b write_hooks develop
mkdir hooks
touch hooks/precommit.sh
git add hooks/precommit.sh
git commit -m "Add pre-commit hook"

git checkout develop
git merge write_templates --no-ff -m "Merge branch 'write_templates' into develop"

git branch write_templates -d

git checkout write_hooks
git rebase develop

touch hooks/postcommit.sh
git add hooks/postcommit.sh
git commit -m "Add post-commit hook"



git checkout -b release_0.0.0 develop
# TEST release_0.2.0 branch

echo "1.0.0" > version.txt
git add version.txt
git commit -m "Update version to 1.0.0"
#


git checkout master
#
git merge --no-ff release_0.0.0 -m "Merge branch 'release_0.0.0. into master"
git tag -a 0.2.0 -m "Templates are ready"


git push origin master
git push origin --tags


git checkout develop
git merge --no-ff release_0.0.0 -m "Merge branch 'release_0.0.0' into develop"
git push origin develop

git branch release_0.0.0 -d

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
git push origin master
git push origin --tags

git checkout develop
git merge --no-ff hot_fix_1.0.0 -m "Merge branch 'hot_fix_1.0.0' into develop"
git push origin develop


git branch hot_fix_1.0.0 -d


git checkout write_hooks
git rebase develop


git checkout develop

git merge write_hooks --no-ff -m "Merge branch 'write_hooks' into develop"

git branch write_hooks -d

git checkout -b release_1.0.1 develop
# TEST release_1.0.1 branch

echo "1.1.1" > version.txt
git add version.txt
git commit -m "Update version to 1.1.1"
#


git checkout master
#
git merge --no-ff release_1.0.1 -m "Merge branch 'release_1.0.1' into master"
git tag -a 1.1.1 -m "Hooks are ready"

git push origin master
git push origin --tags

git checkout develop
git merge --no-ff release_1.0.1  -m "Merge branch 'release_1.0.1' into develop"

git branch release_1.0.1 -d
git push origin develop


gitk  --all
cd -
rm $member1 -rf
rm $origin_dir -rf
