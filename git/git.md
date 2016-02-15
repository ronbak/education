# Tut about console git
- git add . // add all files
- git commit -m "message" // make a commit
- git push // push everything to a branch
- git checkout -b dev // make a branch "dev"
- git checkout master // move to master
- git checkout // move to the last state
- git pull --rebase upstream master //обновление форка из оригинала

Добавляем новый файл в репозиторий и делаем коммит:
>git add TODO.TXT
git commit -a

Поскольку я не указал описание коммита, запускается редактор VIM, с помощью которого я и ввожу описание. Затем я отправляю все сделанные мною изменения на БитБакет:
>git push origin

Допустим, теперь я хочу сделать некоторые изменения в проекте, но не уверен, выйдет ли из этого что-то хорошее. В таких случаях создается новая ветка:
>git branch new_feature
git checkout new_feature

Работаем с этой веткой. Если ничего хорошего не вышло, возвращаемся к основной ветке (она же «trunk» или «ствол»):
>git checkout master

Если вышло что-то хорошее, мерджим ветку в master (о разрешении конфликтов рассказано в следующем параграфе):
>git commit -a # делаем коммит всех изменений в new_feature
git checkout master # переключаемся на master
git merge new_feature # мерджим ветку new_feature

Не забываем время от времени отправлять наш код на BitBucket:
>git push origin

Если мы правим код с нескольких компьютеров, то перед началом работы не забываем «накатить» в локальный репозиторий последнюю версию кода:
>git pull origin

Работа в команде мало чем отличается от описанного выше. Только каждый программист должен работать со своей веткой, чтобы не мешать другим программистам. Одна из классических ошибок при начале работы с Git заключается в push’е всех веток, а не только той, с которой вы работали. Вообще я бы советовал первое время перед выполнением каждого push делать паузу с тем, чтобы подумать, что и куда сейчас уйдет. Для большей безопасности советую при генерации ssh-ключей указать пароль. Тогда каждый запрос пароля со стороны Git будет для вас сигналом «Эй, ты делаешь что-то, что затронет других».

Для работы с Git под Windows можно воспользоваться клиентом TortoiseGit. Если память не изменяет, для нормальной работы ему нужен MSysGit. Для генерации ключей можно воспользоваться утилитой PuTTyGen, только не забудьте экспортировать открытый ключ в правильном формате, «Conversions → Export OpenSSH key».

Следует отметить, что мне лично TortoiseGit показался каким-то глючноватым и вообще не слишком удобным. Возможно, это всего лишь дело привычки, но мне кажется намного удобнее работать с Git из консоли, чем с помощью контекстного меню в Проводнике. Так что по возможности я бы советовал работать с Git в Юниксах. В крайнем случае можно поставить виртуальную машину, установить под ней FreeBSD (безо всяких GUI) и работать в этой виртуальной машине.
## Шпаргалка по командам
В этом параграфе приведена сухая шпаргалка по командам Git. Я далеко не спец в этой системе контроля версий, так что ошибки в терминологии или еще в чем-то вполне возможны. Если вы видите в этом разделе ошибку, отпишитесь, пожалуйста, в комментариях.

Создать новый репозиторий:
>git init project-name

Если вы планируете клонировать его по ssh с удаленной машины, также скажите:
>git config --bool core.bare true

… иначе при git push вы будете получать странные ошибки вроде:
>Refusing to update checked out branch: refs/heads/master
By default, updating the current branch in a non-bare repository
is denied, because it will make the index and work tree inconsistent
with what you pushed, and will require 'git reset --hard' to match
the work tree to HEAD.

Клонировать репозиторий с удаленной машины:
>git clone git@bitbucket.org:afiskon/hs-textgen.git

Добавить файл в репозиторий:
>git add text.txt

Удалить файл:
>git rm text.txt

Текущее состояние репозитория (изменения, неразрешенные конфликты и тп):
>git status

Сделать коммит:
>git commit -a -m "Commit description"

Сделать коммит, введя его описание с помощью $EDITOR:
>git commit -a

Замерджить все ветки локального репозитория на удаленный репозиторий:
>git push origin

Аналогично предыдущему, но делается пуш только ветки master:
>git push origin master

Запушить текущую ветку, не вводя целиком ее название:
>git push origin HEAD

Замерджить все ветки с удаленного репозитория:
>git pull origin

Аналогично предыдущему, но накатывается только ветка master:
>git pull origin master

Накатить текущую ветку, не вводя ее длинное имя:
>git pull origin HEAD

Скачать все ветки с origin, но не мерджить их в локальный репозиторий:
>git fetch origin

Аналогично предыдущему, но только для одной заданной ветки:
>git fetch origin master

Начать работать с веткой some_branch (уже существующей):
>git checkout -b some_branch origin/some_branch

Создать новый бранч (ответвится от текущего):
>git branch some_branch

Переключиться на другую ветку (из тех, с которыми уже работаем):
>git checkout some_branch

Получаем список веток, с которыми работаем:
>git branch # звездочкой отмечена текущая ветвь

Просмотреть все существующие ветви:
>git branch -a # | grep something

Замерджить some_branch в текущую ветку:
>git merge some_branch

Удалить бранч (после мерджа):
>git branch -d some_branch

Просто удалить бранч (тупиковая ветвь):
>git branch -D some_branch

История изменений:
>git log

История изменений в обратном порядке:
>git log --reverse

История конкретного файла:
>git log file.txt

Аналогично предыдущему, но с просмотром сделанных изменений:
>git log -p file.txt

История с именами файлов и псевдографическим изображением бранчей:
>git log --stat --graph

Изменения, сделанные в заданном коммите:
>git show d8578edf8458ce06fbc5bb76a58c5ca4a58c5ca4

Посмотреть, кем в последний раз правилась каждая строка файла:
>git blame file.txt

Удалить бранч из репозитория на сервере:
>git push origin :branch-name

Откатиться к конкретному коммиту (хэш смотрим в «git log»):
>git reset --hard
 d8578edf8458ce06fbc5bb76a58c5ca4a58c5ca4

Аналогично предыдущему, но файлы на диске остаются без изменений:
>git reset --soft d8578edf8458ce06fbc5bb76a58c5ca4a58c5ca4

Попытаться обратить заданный commit (но чаще используется branch/reset + merge):
>git revert d8578edf8458ce06fbc5bb76a58c5ca4a58c5ca4

Просмотр изменений (суммарных, а не всех по очереди, как в «git log»):
>git diff # подробности см в "git diff --help"

Используем vimdiff в качестве программы для разрешения конфликтов (mergetool) по умолчанию:
>git config --global merge.tool vimdiff

Отключаем диалог «какой mergetool вы хотели бы использовать»:
>git config --global mergetool.prompt false

Разрешение конфликтов (когда оные возникают в результате мерджа):
>git mergetool

Создание тэга:
>git tag some_tag # за тэгом можно указать хэш коммита

Удаление untracked files:
>git clean -f

«Упаковка» репозитория для увеличения скорости работы с ним:
>git gc

Иногда требуется создать копию репозитория или перенести его с одной машины на другую.
Это делается примерно так:
>mkdir -p /tmp/git-copy
cd /tmp/git-copy
git clone --bare git@example.com:afiskon/cpp-opengl-tutorial1.git
cd cpp-opengl-tutorial1.git
git push --mirror git@example.com:afiskon/cpp-opengl-tutorial2.git

Следует отметить, что Git позволяет использовать короткую запись хэшей. Вместо «d8578edf8458ce06fbc5bb76a58c5ca4a58c5ca4» можно писать «d8578edf» или даже «d857».
Дополнительные материалы
В качестве источников дополнительной информации я бы рекомендовал следующие:
Why Git is Better than X;
Хабростатья «Почему Git?»;
Книга «Pro Git» на русском языке;
Книга «Волшебство Git» на русском языке;
Как обычно, любые замечания, дополнения и вопросы категорически приветствуются. И кстати, с наступающим вас!

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
