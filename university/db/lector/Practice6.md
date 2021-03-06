# Practice 6

## Введение в БД

### SQL-запросы.
------------------

посмотрим список всех девушек студенток  
> SELECT *   
  FROM persons  
  WHERE persons_type = 'Студент';

 Этот запрос должен вывести в таблице, с похожими данными, что и:
> SELECT *     
  FROM students  
  WHERE sex = 'Ж';


### LIKE, ILIKE, SIMILAR TO  
В некоторых случаях у нас появляется необходимость искать частичное совпадение. Например, необходимо отобрать все фамилии на определенную букву, либо найти определенные слова в тексте. Для этого есть команда LIKE, которая может быть использована в WHERE-условии.  
 Например:  
--выведим только id тех, кто из Москвы, испульзуя LIKE и ILIKE
> SELECT id_student  
  FROM students  
  WHERE town ILIKE 'Москва';   

  В данном случае запрос отберет все строки, в которых фамилия равна конкретному значению. В данном случае оператор LIKE ведет себя аналогично оператору равенства (‘=’). При этом, LIKE позволяет искать соответствие некоторому шаблону. Шаблон строится по следующим правилам:  
каждый символ соответствует самому себе  
% - подразумевает любое количество любых символов  
_ - подразумевает один любой символ  


> SELECT id_student   
 FROM students   
 WHERE town LIKE 'москва';  
--(ничего не выдаст из-за реестра)  

Стоит упомянуть, что команда LIKE регистрозависимая, т.е. символы ‘A’ и ‘a’ не равны. Есть регистронезависимая версия данной команды - ILIKE.

В случае, если нужны более широкие возможности поиска подстрок (регулярные выражения), есть команда, которая принимает классические регулярные выражения - SIMILAR TO.

### ORDER BY
В данном блоке задается порядок сортировки данных.
Добавив несколько записей, нам может показаться, что по умолчанию данные сортируются по ID. Но это предположение ложно.  И опровергнуть мы его можем, например, обновив (UPDATE) одну из записей. Дело в том, что СУБД не гарантирует никакую сортировку по умолчанию. И обычно она выводит их в том порядке, в котором данные записаны на диске. Именно поэтому обновленная запись скорее всего попадет в конец результата запроса.

<u>Синтаксис:</u>  
> SELECT список_выбора  
    FROM табличное_выражение  
    ORDER BY выражение_сортировки1 [ASC | DESC] [NULLS { FIRST | LAST }]  
    [, выражение_сортировки2 [ASC | DESC] [NULLS { FIRST | LAST }] ...]  

--запросим данные студентов, остортированные по убыванию кода группы
>   SELECT s.id,s.group_id, p.name, p.surname  
    FROM students s, persons p  
    WHERE s.id_person = p.id  
    ORDER BY group_id DESC;  

<i>Стоит отметить, что параметры сортировки задаются отдельно для каждого столбца, и вы можете отсортировать один столбец по возрастанию, другой - по убыванию.  
Обратите внимание (sort_expression1), сортировка может быть определена не только по столбцу, а по значению - например, сумма двух значений и т.п.  
Открытым остается вопрос, как сортируется значение NULL? Дело в том, что NULL не может быть сравнено с другими значениями (что естественно, при условии, что его нельзя сравнить даже с самим собой). Поэтому в PostgreSQL есть возможность при сортировке задать правила сортировки для NULL, добавив для столбца параметр NULLS со значением FIRST, либо LAST:  
> ORDER BY surname ASC NULLS FIRST

в данном случае все строки с пустым значением в поле surname попадут в начало.
Значение NULL считается самым “тяжелым”; больше самого большого. Поэтому по умолчанию при выборе порядка ASC используется NULLS LAST, а при DESC - NULLS FIRST.</i>

### LIMIT

При выборке часто бывает ситуация, когда нам нужна только часть данных. Например, постраничный вывод (pagination). Количество записей в результате определяется в блоке LIMIT. LIMIT указывает максимальное количество записей, которое попадет в результат.  

> SELECT список_выборки  
    FROM табличное_выражение  
    [ ORDER BY ... ]  
    [ LIMIT { число | ALL } ] [ OFFSET число ]  

Стоит заметить, LIMIT никак не влияет на порядок. Поэтому один и тот же запрос может давать разный результат. Поэтому чаще всего LIMIT используется с ORDER BY.  

Так же в блоке LIMIT есть полезное дополнение - смещение (OFFSET).   В данном блоке мы указываем, сколько записей нам надо пропустить.   Опять же это используется в постраничном выводе.  

Например:
--запросим данные  всех студентов, осортированные по возрастанию. Причем, результат нашей выборки будет  
--ограничен нам покажут только 3 записи, смещенные на 2 записи от начала.
>   SELECT s.id,s.group_id, p.name, p.surname  
    FROM students s, persons p  
    ORDER BY p.surname  
    LIMIT 3 OFFSET 2;  

ЗАМЕЧАНИЕ. Пропущенные с помощью offset данные в любом случае проходят выборку, поэтому при большом значении offset запрос будет медленным


--посмотрим на пересечние всех строк из таблицы persons и students, где id совпадают
> SELECT s.*, p.*  
  FROM students s, persons p   
  WHERE p.id = s.id_person;  

### DISTINCT  

После того как обработан список выбора, результирующая таблица может быть дополнительно обработана для исключения дублирующихся строк. Чтобы выполнить этоб непосредственно после SELECT пишется ключевое слово DISTINCT:  
> SELECT DISTINCT список_выбора ...  

(Вместо ключевого слова DISTINCT может быть использовано ключевое слово ALL, которое задаёт поведение по умолчанию, обуславливающее выдачу всех строк.)  
В общем случае, две строки считаются отличными друг от друга, если они различаются хотя бы одним значением колонки. Значения при сравнении NULL считаются равными.  
В качестве альтернативы, какие строки должны считаться отличными друг от друга может определить указанное выражение:  
> SELECT DISTINCT ON (выражение [, выражение ...]) список_выбора ...  

Здесь выражение является заданным значением выражения, которое применяется ко всем строкам. Список строк, которым будет соответствовать данное выражение, будет считаться дублирующим и при выводе результатов останется только первая строка этого списка. Обратите внимание, что какая именно строка будет "первой строкой" непредсказуемо, если результат запроса не сортируется по нужным колонкам, чтобы гарантировать уникальный порядок строк, полученных после фильтра DISTINCT. (Обработка DISTINCT ON происходит после сортировки ORDER BY.)  

--запросим все имеющиеся кафедры 
> SELECT DISTINCT  department  
FROM professors;   

Предложение DISTINCT ON не является частью стандарта SQL и иногда считается плохим стилем, потому что потенциально может привести к неожиданным результатам. При разумном использовании GROUP BY и подзапросов в FROM, данное предложение может быть опущено, но часто оно является наиболее удобной альтернативой.   

### HAVING

Порой у нас бывает потребность группироваться данные по определенному признаку. Например, необходимо посчитать среднюю температуру, количество студентов в группе, максимальную стоимость товара в категории, либо применить прочую агрегирующую функцию.  

Мы не можем перечислить в select поля, к которым не были применены агрегирующие функции. Данное поведение регламентировано стандартом.   
Замечание. Данное ограничение не работает в MySQL. Имейте ввиду!  

Группировка возможна по нескольким полям.  

Возможно, что после группировки нам необходимо провести дополнительную фильтрацию. Кажется, что для этого стоит использовать блок WHERE. Но нет! WHERE фильтрует данные до группировки. Нам же нужна фильтрация после группировки. Для этого используется блок HAVING.  

Замечание. В блоке HAVING мы не можем использовать псевдонимы столбцов, которые мы назначили в блоке SELECT.  

 Например:
 -- вывести те группы, число студентов ссылающихся на которые меньше 2:

> SELECT	*  
 FROM groups g INNER JOIN students s ON (g.id = s.group_id)  
 GROUP	BY s.id, g.id  
 HAVING	COUNT(*) < 2;  