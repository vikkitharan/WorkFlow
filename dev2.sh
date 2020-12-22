#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# Bash script to simulate the git work flow
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=$(mktemp -d)

Dev_name="Soodai Fish"
Dev_email="S.Fish@email.com"


cd $dir
# step 5: clone
git clone "/tmp/gitworkFlow" ./

git config user.name $Dev_name
git config user.email $Dev_email


# step6:
git checkout develop
git checkout -b write_hooks develop
mkdir hooks
touch hooks/precommit.sh
git add hooks/precommit.sh
git commit -m "Add pre-commit hook"


touch hooks/postcommit.sh
git add hooks/postcommit.sh
git commit -m "Add post-commit hook"

# step 9:
git fetch origin master
git fetch origin develop

git rebase origin/develop develop
git rebase origin/master master

git checkout develop

# step 10:
git merge write_hooks --no-ff -m "Merge branch 'write_templates' into develop"
git branch write_hooks -d



# step 11:
git checkout -b release_0.0.0 develop
# TEST release_0.2.0 branch

# step 12:
echo "1.0.0" > version.txt
git add version.txt
git commit -m "Update version to 1.0.0"



git checkout master

# step 14:
git merge --no-ff release_0.0.0 -m "Merge branch 'release_0.0.0. into master"
git tag -a 0.2.0 -m "Templates are ready"

# step 15:
git checkout develop
git merge --no-ff release_0.0.0 -m "Merge branch 'release_0.0.0' into develop"

git branch release_0.0.0 -d

git fetch origin master
git fetch origin develop

# TODO [vikgna @20/12/21]:rebase does not suit here why?. #
git merge origin/develop develop
git merge origin/master master


git push origin master
git push origin develop
git push origin --tags



gitk  --all
rm $dir -rf
