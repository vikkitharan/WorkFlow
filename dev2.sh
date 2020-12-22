#!/bin/bash
#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# This is the 2nd developer's script
# He makes a feature branch and a releases it to master
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
dir=/tmp/dev2
mkdir $dir

Dev_name="Soodai Fish"
Dev_email="S.Fish@email.com"


cd $dir
# step 5: clone
git clone "/tmp/gitworkFlow" ./


# init local configuration
git config user.name $Dev_name
git config user.email $Dev_email

git remote -v
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

# update develop branch
git checkout develop
git pull origin


## step 10:
# update feature branch
git checkout write_hooks
git rebase develop

git checkout develop
git merge write_hooks --no-ff -m "Merge branch 'write_templates' into develop"
git branch write_hooks -d

# step 11:
git checkout -b release_1.0.0 develop
# TEST release_0.2.0 branch

# step 12:
echo "1.0.0" > version.txt
git add version.txt
git commit -m "Update version to 1.0.0"

# step 14:
#update master branch
git checkout master
git pull origin
git merge  release_1.0.0 --no-ff -m "Merge branch 'release_1.0.0. into master"
git tag -a 1.0.0 -m "Templates are ready"
#
# step 15:
git checkout develop
git pull origin
git merge release_1.0.0 --no-ff -m "Merge branch 'release_1.0.0' into develop"

git branch release_1.0.0 -d


git push --all
git push origin --tags

gitk  --all
