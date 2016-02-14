# Tut about console git
- git add . // add all files
- git commit -m "message" // make a commit
- git push // push everything to a branch
- git checkout -b dev // make a branch "dev"
- git checkout master // move to master
- git checkout // move to the last state

/_ Set up Git Configuration _/

git config --global user.email "you@yourdomain.com"

git config --global user.name "Your Name"

git config --global core.editor "vi"

git config --global color.ui true

/_ See Git configuration _/

git config --list

/_  To initialise a local repository _/

git init

/_  Add a file to the repo _/

git add

/_ commit the change to git _/

git commit -m "Message goes here"

/_  see the commits _/

git log

/_  Git has a 3 Tier Architecture:  Working - Staging - Repo Changes to files are put in a Checksum SHA-1 hash 40digit value containing parent hash, author and message. HEAD is the latest commit of the checked out branch _/

/_  Basic Commands  _/

git status  /_  the command 'git status' tells which files are not added or committed from Working to Staging to Repository _/

git commit -m "" /_  Commits and changes to all files that are in Staging into Repo  _/

git diff /_  show changes between Working and Local Repo, no file supplied shows all files  _/

git diff --staged /_  shows changes between Staged and Local Repo  _/

git rm file.txt /_  will remove file from working then git commit -m "" to also remove from Repo _/

git rm --cached file.txt /_ leaves copy of file in Working but removes from Staging and Repo _/

git mv /_  rename or move files - then git commit -m "" to move to Repo _/

git commit -am "text goes here" /_ adds all files straight to Repo from Staging if they have changes - meaning they skip git add _/

git checkout -- file.txt /_  restore Repo file to Working Directory using current branch  _/

git reset --soft HEAD^ /_ restore repo file to staging _/

git reset HEAD file.txt /_  Move a Stage file out of Stage back to Working _/

git commit --amend -m "message" file.txt /_ Change last commit to Repo (only last one can change) _/

/_ Reverting --soft --mixed --hard will go back to previous commits_/ git log /_ gets the sha1s so you can see the coomits where you want revert  back to  _/

git reset --soft sha /_ changes Repo but not Staging or Working _/

git reset --mixed sha /_ changes Repo and Staging but not Working _/

git reset --hard sha /_ changes all 3 Tiers _/

git clean -f /_ remove untracked files from Working  _/

.gitignore /_ ignores files to track in Working / track the .gitignore file _/

Global Ignore /_ create in home folder  _/ .gitignore_global /_ Add in  _/ .DS_Store .Trashes .Spotlight_V100

git config --global core.excludesfile ~/.gitignore_global /_ add to gitconfig _/

/_ Stop tracking changes _/

git rm --cached file.txt /_ leaves copy in Repo and Working _/

/_ Track Folders changes Add an invisble file to a folder like .gitkeeper then add and commit _/

/_ Commit Log  _/ git ls-tree HEAD git ls-tree master git log --oneline git log --author="Neil" git log --grep="temp"

/_ Show Commits _/

git show dc094cb /_  show SHA1 _/

/_ Compare Commits Branches _/

git branch /_  Show local branches _ is the one we are on */

git branch -r /_ Shows remote branches _/

git branch -a /_ Shows local and remote _/

git branch newbranch /_ creates a new branch _/

git checkout newbranch /_ switch to new branch _/

git checkout -b oldbranch /_ creates and switches to new branch  _/

git push origin newbranch /_ Push new branch to remote _/

/_ Diff in Branches _/

git diff master..otherbranch /_  shows diff _/

git diff --color-words master..otherbranch /_  shows diff in color _/

git branch --merged /_  shows any merged branches _/

/_ Rename Branch _/

git branch -m oldname newname

/_ Delete  Branch _/

git branch -d nameofbranch

/_ Merge Branch  _/

git merge branchname /_ be on the receiver branch to merge the other branch _/

/_ Merge Conflicts between the same file on 2 branches are marked in HEAD and other branch _/

git merge --abort /_  Abort basically cancels the merge _/

/_ Manually Fix Files and commit The Stash _/

git stash save "text message here"

git stash list /_ shows whats in stash _/

git stash show -p stash@{0} /_ Show the diff in the stash _/

git stash pop stash@{0} /_  restores the stash deletes the tash _/

git stash apply stash@{0} /_  restores the stash and keeps the stash _/

git stash clear /_  removes all stash _/

git stash drop stash@{0}

/_ Remotes You can push and fetch to the remote server, merge any differences - then push any new to the remote - 3 branches work remote server branch, local origin master and local master Create a repo in GitHub, then add that remote to your local repo _/

git remote add origin [https://github.com/neilgee/genesischild.git](https://github.com/neilgee/genesischild.git) /_  origin can be named whatever followed by the remote _/

git remote /_ to show all remotes _/

git remote show origin /_to see remote URL_/

git remote remove origin /_ to remove remote _/

git remote rm origin /_ to remove remote _/

/_ Push to Remote from Local _/

git push -u origin master /_ push to remote(origin) and branch(master) /_ Cloning a GitHub Repo - create and get the URL of a new repository from GitHub, then clone that to your local repo, example below uses local repo named 'nameoffolder' */

git clone [https://github.com/neilgee/genesischild.git](https://github.com/neilgee/genesischild.git) nameoffolder

/_ Push to Remote from Local - more - since when we pushed the local to remote we used -u parameter then the remote branch is tracked to the local branch and we just need to use... _/

git push

git push origin newbranch /_ Push a branch to a remote _/

/_ Fetch changes from a cloned Repo _/

git fetch origin /_  Pulls down latest committs from remote origin/master not origin, also pull down any branches pushed to Repo Fetch before you work Fetch before you pull Fetch often _/

/_ Merge with origin/master _/

git merge origin/master

git pull /_ you can also do git pull which is = git fetch + git merge Checkout/Copy a remote branch to local _/

git branch branchname origin/branchname /_  this will bring the remote branch to local and track with the remote _/

/_ Delete branch _/

git branch -d branchname

/_ Checkout and switch branch and track to remote _/

git checkout -b nontracking origin/nontracking

/_ Remove remote branch _/

git push origin --delete branch

/_Undoing_/

git checkout path-to-file /_restores a file before it is staged _/

git reset HEAD path-to-file /_if it is staged - restores a file from last commit and then git checkout path-to-file _/

git checkout HEAD^ path-to-file /_if is staged and committed - restores from last commit _/

git reset --hard HEAD^ /_restore prior commit _/

/_Keeping a Fork synced with the original repo_/

git remote add upstream [https://github.com/user/originalrepo](https://github.com/user/originalrepo) /_ From the forked repo - add the original master repo _/

git pull upstream master /_ Sync it up _/

/_Tags_/

git tag -a v1.0.0 -m "add message here" /_tagging a commit with a version number_/

git push --tags /_ pushes tag info to master remote _/

/_You can checkout a commit and add a tag to that commit by checking out its SHA _/

git checkout f1f4a3d /_checking out a commit - see the commit SHAS by git log _/

/_Changing Tag to different commit _/

git tag -d v1.0.0 /_change version number to suit - we are deleting it here_/ git push origin :refs/tags/v1.0.0 /_push change to remote_/ git tag v1.0.0 /_create new tag - change version number to suit _/ git push origin master --tags /_ assign to latest commit _/
