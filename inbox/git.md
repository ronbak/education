# Tut about console git
- git add . // add all to HEAD
- git commit -m "message" // make a commit
- git push // push everything to a branch
- git checkout -b dev // make a branch "dev"
- git checkout master // move to master
- git checkout dev // move back to dev
- git pull --rebase upstream master //обновление форка из оригинала

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

git config --global user.email "you@yourdomain.com"

git config --global user.name "Your Name"

git config --global core.editor "vi"

git config --global color.ui true

/_ See Git configuration _/
