Git might be the best version control software and it has overwhelming features. If we do not use git properly, we would end up with confusion and frustration.

I get frustrated when I find the master branch is broken when it is needed urgently. So I decided to document good workflow version control using git.

**I cite the sources, where I gather the information. This guide is my personal opinion. Please make your judgment before accepting it.**

Here I summarize how I use git workflow my professional and personal use.
I follow this workflow for complex projects or simple projects.

# DON'T
1. Do not rewrite published history
2. Do not commit any unverified/untested changes to the master branch
3. Do not commit logically different changes together
2. Do not commit generated files

# DOs
1. Keep the master branch ready to use anytime
2. Create topic (feature) branches
3. Stash your half-done work
4. Commit early, commit often
5. Re base your feature branches often
6. Use tags
- After you have finished testing and are ready to deploy the software from the master branch, or if you want to preserve the current state as a significant milestone for any other reason, create a Git tag.
- Make the software executable print the tag. Typically, the tag string git describe generates is inserted into the code before code compilation so that the resulting executable will print the tag string while booting up

- use `git describe` to get tag
-
6. Squash commits before merging?
6. Write meaningful commit messages
7. Make use of hooks


# Branches
The master and the develop are two infinite life span branches and other branches are short living branches.
The master and the develop branches are published.


## master
The master is the **production-ready**; anytime it is ready for production. But it may not be the most updated branch.

Update the main branch only after testing  thoroughly the branch which is merged into the master.

Make sure every commits in the master branch is [versioned](#version).

The master branch should be updated by one of three ways.

1. Initial commit with version 0.0.0
```
git init
git add README.md
git commit -v
git tag -a 0.0.0 -m "Initial commit"
```
2. By merging [hot\_fix branch](#hot_fix) into the master branch.
3. By merging [release branch](#release) into the master branch.

## hot\_fix
If the master branch is broken,
1. Inform all developers
2. Pull the master branch from origin.
```
git fetch --all
git checkout master
git merge origin/master
```
2. Create a short life branch (named hot\_fix\_x.y.Z). The latest tag of the main branch is x.y.z and Z = z + 1.
3. Fix the bug (1st commit)
4. Verify and review the fix
5. Perform regression tests
6. Fix if any test fails (2nd commit)
6. Update the version to x.y.Z (3rd commit)
7. Merge hot\_fix\_x.y.Z into the develop branch
```
git merge --no-ff hot_fix_1.0.1 -m "Merge branch 'hot_fix_1.0.1' into develop"
```
8. Merge hot\_fix\_x.y.Z into the master branch
```
git merge --no-ff hot_fix_1.0.1 -m "Merge branch 'hot_fix_1.0.1' into master"
```
9. Tag the master branch with x.y.Z
```
git tag -a 1.0.1 -m "Fix broken link"
```
10. Delete hot\_fix\_x.y.Z branch
```
git branch hot_fix_1.0.1 -d
```
12. Push the local the master branch to origin
```
git push --all
git push origin --tags
```


Rewriting the history of the master branch would lead to frustrations. So do not `rebase`, `revert`, or `ammend` commands.

## develop
**develop** is the most updated branch and it is ready for next release.
It is the most updated and contains more commits than any other branches.
Small changes can be added directly to the develop branch. A feature development should have been done using a [feature branch](#feature).
Create the develop branch soon after the initial commit.
```
git checkout -b develop master
```

As the develop may become messy as it has many commits and feature branches are merged into it.
Updating local the develop branch and rebasing feature branches frequently would help to maintain the clean develop branch.

Do not rewrite the develop branch once it is published. The commits after origin/develop are local commits so you can update them.




## feature
One of the advantages of git (distributed system) over centralized version control systems is making branches are very light weight to create and use.
You should create a [feature branch](#feature). It would have many commits.

1. Pull the develop branch from origin.
```
git fetch --all
git checkout develop
git merge origin/develop
```
2. Create a feature branch from the develop branch
```
git checkout -b write_templates develop
```
3. Add the initial commit to the branch (prologue commit): write down plan of the implementation, todo list, required tests and etc one a text file (Like README); and the last commit would be epilogue: update version and clean up the prologue.
```
echo "Add templates of commits">write\_templates.txt
git add write\_templates.txt
git commit -m "Add proloque commit"
```
4. Add more commits,
5. rebase the branch if local or origin develop branch is updated
6. Review the branch
7. merge with the develop
```
git checkout develop
git merge write_templates --no-ff -m "Merge branch 'write_templates' into develop"
```
8. Delete the branch
```
git branch write_templates -d
```
9. Push to origin
```
git push --all
git push origin --tags
```



## release
**release** branch is similar to [hot\_fix](#hot\_fix), but release branch is branch out from [develop](#develop) branch and it is a well planned event.

1. Pull the develop branch from origin.
```
git fetch --all
git checkout develop
git merge origin/develop
```
2. Determine release point, may not be the last commit
4. List all changes edit the changes and determine the branch name release\_X.Y.Z.The latest tag of the main branch is x.y.z
```
git ln x.y.z..last_commit_id > changes.txt
```
If this is a block point change X = x + 1
3. Create a short life named release\_X.Y.Z.

5. Perform regression tests
6. Fix if any test fails

7. Merge release\_X.Y.Z into the develop branch
```
git checkout develop
git pull origin
git merge release_1.0.0 --no-ff -m "Merge branch 'release_1.0.0' into develop"
```
8. Merge release\_X.Y.Z into the master branch
```
git checkout master
git pull origin
git mergerelease_1.0.0 --no-ff -m "Merge branch 'release_1.0.0. into master"
```
9. Tag the master branch with X.Y.Z
```
git tag -a 1.0.0 -m "Templates are ready"
```
10. Delete release\_X.Y.Z branch
```
git branch release_1.0.0 -d
```
12. Push the local master branch to origin
```
git push --all
git push origin --tags
```





# Version
The version has tree fields; major, minor and patch.


version= major.minor.patch

major = numeric identifier

minor = numeric identifier

patch = numeric identifier

For the comprehensive details of versioning software, refer [Semantic Versioning 2.0.0](https://semver.org/#semantic-versioning-200). It is less than 30 minutes of reading.

## Tags



# Hooks

pre-commit: Check the commit message for spelling errors.
pre-receive: Enforce project coding standards.
post-commit: Email/SMS team members of a new commit.
post-receive: Push the code to production.


https://githooks.com/

# FAQs #
1. When to rebase a branch and when to merge a branch?
2. When to revert a commit safe?
3. When to cherry-pick a commit?

# Do's #
- push the master and the develop branches to origin from beginning
- push the master or the develop once any branches merge into the master or develop branches.


# References #
1. [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
2. [Pro Git Book](https://git-scm.com/book/en/v2)

