+DROP DATABASE tim; --удалим бд, если бд с таким названием уже имеется
CREATE DATABASE tim;--создадим нашу бд

CREATE TYPE PERSONS_TYPE AS ENUM ('Профессор', 'Студент');
--Перечисления (enum) — это такие типы данных, которые состоят из статических, упорядоченных списков значений.


CREATE TABLE persons (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
persons_type PERSONS_TYPE NOT NULL
);

INSERT INTO persons (name, surname,persons_type) VALUES ('Гульнара', 'Нигматзянова','Студент'), ('Эмиль', 'Атажанов','Студент'),
 ('Илюза', 'Сакаева','Студент'), ('Захар','Макаров','Студент'),('Алина', 'Васильева','Студент'),('Камиль', 'Морковников','Студент'),
 ('Марина', 'Петрушкина','Студент'),('Захар','Огурцов','Студент'),('Лариса', 'Блинчикова','Студент'),('Екатерина','Федулова','Студент'),
 ('Анвар','Туйкин', 'Профессор'),('Наиль','Бухараев', 'Профессор'),('Элина','Степанова', 'Профессор'),
 ('Арслан','Еникеев', 'Профессор'),('Александр','Гусенков', 'Профессор'),
 ('Виктор','Георгиев', 'Профессор'),('Михаиль','Щелкунов', 'Профессор'),
 ('Евгения','Михайловна', 'Профессор'),('Алия','Барисовна', 'Профессор'),
 ('Динара','Торфянова','Студент'),('Кристина','Аркадъевна','Студент'),('Вася','Пупкин','Студент'),
 ('Михаиль','Мочалкин','Студент'),('Иван','Иванов','Студент'),('Мария','Владимировна', 'Профессор'),('Критерий','Пирсона', 'Профессор'),
 ('Сергей','Мокичев', 'Профессор'),('Фаниль','Серебряков', 'Профессор'), ('Виолетта','Чебакова', 'Профессор'),
  ('Екатерина','Турилова', 'Профессор'),('Самигулла','Халиуллин', 'Профессор');


CREATE TYPE GENDER AS ENUM ('М', 'Ж');-- создадим тип для поля пол

CREATE TABLE students ( 
	id SERIAL PRIMARY KEY,
	id_person INTEGER UNIQUE,
	sex GENDER NOT NULL,
	group_id INTEGER NOT NULL,
	town VARCHAR(50) NOT NULL DEFAULT 'Казань',
	CHECK (group_id >= 1),
	FOREIGN KEY (id_person) REFERENCES persons(id) ON DELETE SET NULL
);

DELETE FROM students; --удалим якобы имеющиеся данные в таблице студенты
 
--посмотрим список всех девушек студенток
 SELECT *
 FROM persons
 WHERE persons_type = 'Студент' AND surname LIKE '%а';

--добавим данные
INSERT INTO students (id_person,group_id,sex, town) VALUES (1,1,'Ж',DEFAULT),
(3,4,'Ж','Рязань'),(5,3,'Ж','Москва'),(7,2,'Ж','Крым'),
(9,5,'Ж',DEFAULT),(10,1,'Ж','Тверь'),(20,1,'Ж','Уфа'),(21,1,'Ж','Алексеевск');
 
--запросим всех парней студентов
  SELECT *
 FROM persons
 WHERE persons_type = 'Студент' AND surname NOT LIKE '%а';

--добавим данные
INSERT INTO students (id_person,group_id,sex,  town) VALUES (2,5,'М','Москва'),
(4,5,'М',DEFAULT),(6,7,'М',DEFAULT),(8,1,'М','Агрыз'),(22,2,'М','Норильск'),(23,2,'М','Стерлитамак'),(24,1,'М','Киев');


--Индексы — один из самых мощных инструментов в реляционных базах данных, который используют,
-- когда нужно быстро найти какие-то значения, для объединения базы данных, ускорение работы SQL-операторов и т.д.
CREATE INDEX id_person ON persons(id);
CREATE INDEX id_student ON students (id);


/*

В каком порядке должны быть указаны данные при использовании команды insert?
-Список столбцов в данной команде не является обязательным параметром.
В этом случае должны быть указаны значения для всех полей таблицы в том порядке,
 как эти столбцы были перечислены в команде CREATE TABLE, например:
 INSERT INTO students VALUES (1,'Гульнара', 'Нигматзянова', 'Ж', '2', DEFAULT);
Что будет, если попытаться вставить запись, которая нарушает ограничение уникальности?
-Если пользователь пытается сохранить в какой-либо колонке данные, которые попадают под ограничение, возникнет ошибка. 
Что будет, если попытаться удалить из таблицы несуществующие значения?
-Запрос будет успешно выполнен, например:DELETE FROM students WHERE town ILIKE 'Махачкала';
*/


--посмотрим на нашу таблицу
SELECT *
FROM students;

UPDATE students 
set town = 'Махачкала'
 WHERE id_student = 1; 

UPDATE students 
set town = DEFAULT
 WHERE id_student = 1; 

/*
Что если в команде UPDATE не указать WHERE?
-Изменятся все данные.
*/


--выведим только id тех, кто из Москвы
SELECT id_student
FROM students
WHERE town ILIKE 'Москва';

SELECT id_student
FROM students
WHERE town LIKE 'москва'; --(ничего не выдаст из-за реестра)

--посмотрим на пересечние всех строк из таблицы persons и students, где id совпадают
SELECT s.*, p.*
FROM students s, persons p 
WHERE p.id = s.id_person ;


CREATE SEQUENCE serial;--создадим последовательность

CREATE TABLE example ( --создадим таблицу для примера использования созданной нами последовательности
	id INTEGER DEFAULT nextval('serial')
);

ALTER TABLE example ADD COLUMN name VARCHAR;--добавим столбец в таблицу
ALTER TABLE example ADD CONSTRAIN colName UNIQUE (name);--добавим ему именнованое ограничение - уникальность
ALTER TABLE example ALTER COLUMN colName SET NOT NULL;--добавим ограничение NOT NULL
ALTER TABLE example ALTER COLUMN colName SET DEFAULT 'Наименование'; --добавим ограничение  DEFAULT
ALTER TABLE example RENAME COLUMN name TO NewName,  RENAME TO newExample;--переименуем столбец и саму таблицу
ALTER TABLE newExample ALTER COLUMN colName DROP DEFAULT;-- уберем ограничение DEFAULT
ALTER TABLE newExample ALTER COLUMN colName DROP NOT NULL;--уберем ограничение NOT NULL
ALTER TABLE newExample DROP CONSTRAIN colName;--уберем ограничение уникальности
ALTER TABLE newExample DROP COLUMN NewName;--удалим столбец

DROP SEQUENCE serial;
--если мы попытаемся удалить последовательность, которая уже используется, у нас это не получится. Поэтому
--удалим сеначала таблицу,а затем уже последовательность.
DROP TABLE example;
DROP SEQUENCE serial;

--вернемся к select
--запросим данные студентов, остортированные по убыванию кода группы
SELECT s.id,s.group_id, p.name, p.surname
    FROM students s, persons p
    WHERE s.id_person = p.id
    ORDER BY group_id DESC;

--запросим данные  всех студентов, осортированные по возрастанию. Причем, результат нашей выборки будет
--ограничен нам покажут только 3 записи, смещенные на 2 записи от начала.
SELECT s.id,s.group_id, p.name, p.surname
 FROM students s, persons p
ORDER BY p.surname
LIMIT 3 OFFSET 2;

--создадим функцию, результатом которой будет записи тех студентов, код которых больше 12.
CREATE FUNCTION one()
 RETURNS SETOF record AS '
select *
  from students
  where id>12;
'
LANGUAGE sql;

--посмотрим на результат функции
SELECT  one() AS result;


--создадим таблицу группы
CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	group_number VARCHAR(10) NOT NULL, --номер/наименование группы
	student_count INTEGER NOT NULL, --число студентов в группе
	faculty VARCHAR(50) NOT NULL, --факультет
	steward INTEGER , --староста (внешний ключ)
	FOREIGN KEY (steward) REFERENCES students(id)  ON DELETE SET NULL 
	
);

// DROP TABLE IF EXISTS groups CASCADE; --если мы на данном этапе удалим таблицу,
-- придется воспользоваться каскадным удалением

INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 6),
 ( '09-400', 28, 'ИВМиИТ', 10), ( '09-307', 30, 'ИВМиИТ', 9), ('09-306', 10, 'ИТИС', 6), ( '09-411', 7, 'ИВМиИТ',2),
( '09-508', 12, 'ИВМиИТ', 3),('09-206', 21, 'ИВМиИТ', 1), ('09-211', 25, 'ИТИС', 4), ('09-221', 25, 'ИТИС', 5);
INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 6),
 ( '09-400', 28, 'ИВМиИТ', 10), ( '09-307', 30, 'ИВМиИТ', 9), ('09-306', 10, 'ИТИС', 6), ( '09-411', 7, 'ИВМиИТ',2),
( '09-508', 12, 'ИВМиИТ', 3),('09-206', 21, 'ИВМиИТ', 1), ('09-211', 25, 'ИТИС', 4), ('09-221', 25, 'ИТИС', 5);
/* мы добавили в нашу таблицу данные, затем повторили. Теперь в нашей таблице дублированные данные.
запросим номер группы и id старосты всех, уникальных по номеру группы, данных.*/
SELECT DISTINCT ON (group_number)
 group_number, steward
FROM groups ; 

--посмотрим на все дублирующиеся данные
SELECT g.*
FROM groups g
INNER JOIN 
(
SELECT group_number, COUNT(*) AS cnt
FROM groups
GROUP BY group_number
HAVING COUNT(*) >1
)b ON (b.group_number= g.group_number);


/*Как справиться с дублирующимися данными???
Сначала я попыталась сделать запрос для удаления их, не смотря на то, что запрос был успешно выполнен содержание
таблицы никак не изменилось :( */

delete
 from groups
 where (group_number,student_count, faculty, steward) 
 not in (SELECT DISTINCT ON (group_number)
 group_number,student_count, faculty, steward
FROM groups);


 --Тогда я воспользовалась этим запросом:

DELETE FROM groups T1 WHERE EXISTS 
  (SELECT * FROM groups T2 WHERE 
     (T2.group_number = T1.group_number or (T2.group_number is null and T2.group_number is null)) AND 
     (T2.student_count = T1.student_count or (T2.student_count is null and T2.student_count is null)) AND 
     (T2.faculty = T1.faculty or (T2.faculty is null and T2.faculty is null)) AND 
     (T2.steward = T1.steward or (T2.steward is null and T2.steward is null)) AND 
     (T2.id > T1.id));

/*Больше дублирующихся данных в таблице нет.
И, чтобы они не повторялись, добавим ограничение на уникальность номера группы.*/
ALTER TABLE groups ADD CONSTRAINT group_number_un UNIQUE (group_number);

 --Попытаемся снова добавить дубликат:
 INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 3),
 ( '09-400', 28, 'ИВМиИТ', 1), ( '09-307', 30, 'ИВ('09-221', 25, 'ИТИС', 24);МиИТ', 8), ('09-306', 10, 'ИТИС', 4), ( '09-411', 17, 'ИВМиИТ', 7),
( '09-508', 12, 'ИВМиИТ', 2),('09-206', 21, 'ИВМиИТ', 2), ('09-211', 25, 'ИТИС', 6),('09-302', 24, 'ИВМиИТ', 21);
--У нас это не получится, тк повторяющееся значение ключа нарушает ограничение уникальности "group_number_un".


--добавим связь. Теперь удаление или изменение родительского ключа распространается на зависящий от него ключ
ALTER TABLE students ADD 
CONSTRAINT stud_group 
FOREIGN KEY (group_id) REFERENCES groups(id)
 ON UPDATE CASCADE ON DELETE SET NULL;
 --но данные в таблице студентов нарушают целостность, поэтому увеличим все коды групп в таблице студентов 

UPDATE  students SET group_id = group_id + 20 ;

--попробуем еще раз и все работает.
ALTER TABLE students ADD 
CONSTRAINT stud_group 
FOREIGN KEY (group_id) REFERENCES groups(id)
 ON UPDATE CASCADE ON DELETE SET NULL;

--посмотрим номер группы, число студентов, факультет и код старосты этой группы.
SELECT g.group_number, g.student_count, g.faculty, s.id
FROM students s INNER JOIN groups g ON (s.id = g.steward);

--чтобы не писать постоянно запрос, создадим представление.
CREATE VIEW Stewards_id AS SELECT g.group_number, g.student_count, 
g.faculty, s.id
FROM students s INNER JOIN groups g ON (s.id = g.steward);

--наше представление совпадает с запросом, написанным ранее.
SELECT * FROM Stewards_id;

--также нам понадобиться представление, с помощью которого мы сможем узнать не только код,но и имя, фамилию старосты.

CREATE VIEW Stewards AS SELECT s_id.group_number, s_id.student_count, 
s_id.faculty, p.name, p.surname 
FROM persons p INNER JOIN Stewards_id s_id ON (s_id.id = p.id);

SELECT *
FROM Stewards
ORDER BY surname;
--теперь мы сможем узнать имена и фамилии старосты конткретной группы одной  простой командой
SELECT *
FROM Stewards
WHERE group_number = '09-308';



--функция, результатом которой будет количество записей в бд о студентах из группы, id которой равно 23
CREATE FUNCTION students_count() RETURNS integer AS '
DECLARE
i integer;

BEGIN
select count(*) from students into i where students.group_id=23;

return i;
END;
' LANGUAGE plpgsql;

SELECT  students_count() AS i;

--запросим минимальное количество студентов среди всех групп.
  SELECT MIN(g.student_count) FROM groups g;

//создадим таблицу профессоров
CREATE TABLE professors (
	id SERIAL PRIMARY KEY,
	id_person INTEGER UNIQUE,
	faculty VARCHAR(50) NOT NULL, 
	classes INTEGER NOT NULL, --REFERENCES classes(id), 
	department VARCHAR(50) NOT NULL 	
);

--запросим всех профессоров из таблицы persons
SELECT *
FROM persons
WHERE persons_type = 'Профессор';

INSERT INTO professors (id_person,faculty,classes,department) VALUES (11,'ИВМиИТ',0,'КТП'),(12,'ИВМиИТ',0,'КТП'),
(13,'ИВМиИТ',0,'КТП'),(14,'ИВМиИТ',0,'КТП'),(15,'ИВМиИТ',0,'КТП'),(16,'ИВМиИТ',0,'КТП'),(17,'ИТИС',0,'КТТ'),
(18,'ИТИС',0,'КТТ'),(19,'ИТИС',0,'КТТ'),(25,'ИТИС',0,'КТТ'),(26,'ИВМиИТ',0,'КМС'),(29,'ИВМиИТ',0,'КМС'),
(30,'ИВМиИТ',0,'КМС'),(31,'ИВМиИТ',0,'КМС'),(27,'ИСФНиМК',0,'КОФ'),(28,'ИУЭиФ',0,'КЭТ');

//Запросим всех профессоров из кафедры Технологии программирования
SELECT *
FROM professors
WHERE department ILIKE 'КТП';

--к сожалению, мы можем увидеть только код того или иного преподавателя. Воспользуемся представлением для более подробной информации

CREATE VIEW professors_ns 
AS SELECT p.name,p.surname,pr.faculty, pr.classes,pr.department
FROM persons p INNER JOIN professors pr
ON (pr.id_person = p.id);

--теперь мы можем увидеть не только код преподавателей, но и имя и фамилию) остортированные по возрастанию
SELECT *
FROM professors_ns
WHERE department ILIKE 'КТП'
ORDER BY surname ;

SELECT * 
FROM professors_ns;  

--функция, которая возвращает количество записей по конкретному значению кафедры
CREATE FUNCTION prof_count(str VARCHAR) RETURNS integer AS '
DECLARE
i integer;

BEGIN

select count(*)
from professors p into i 
where p.department= str;

return i;
END;
' LANGUAGE plpgsql;

--запросим все имеющиеся кафедры и количество профессоров, работающих в них
SELECT DISTINCT  department, prof_count(department) AS i
FROM professors;


CREATE TYPE REPORT_TYPE AS ENUM ('Зачет', 'Экзамен', 'Курсовая');
CREATE TYPE SUBJECT_TYPE AS ENUM ('Лекция', 'Практика');


CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	report_type REPORT_TYPE NOT NULL,
	subject_type SUBJECT_TYPE NOT NULL,
	hours INTEGER NOT NULL
);

INSERT INTO subjects (name, report_type, subject_type, hours) VALUES ('Базы Данных', 'Зачет', 'Лекция', 18), ('Базы Данных', 'Зачет', 'Практика', 18);
INSERT INTO subjects (name, report_type, subject_type, hours) VALUES ('ПАПС', 'Зачет', 'Лекция', 18), ('ПАПС', 'Зачет', 'Практика', 36), ('ТПО', 'Зачет', 'Лекция', 18),
 ('ТПО', 'Зачет', 'Практика', 36), ('ОИБ', 'Экзамен', 'Лекция', 36), ('ОКГ', 'Зачет', 'Практика', 18), ('ОКГ', 'Зачет', 'Практика', 36), ('Физ-ра', 'Зачет', 'Практика', 66);

 //запросим все лекционные предметы по возрастанию количества часов

SELECT *
FROM 
(SELECT DISTINCT ON (s.name) *
FROM subjects s
WHERE s.subject_type = 'Лекция'
ORDER BY s.name DESC) ss
ORDER BY ss.hours DESC;


CREATE TABLE classes (
	id SERIAL PRIMARY KEY,
	professors_id INTEGER NOT NULL ,
	group_id INTEGER NOT NULL,
	subject_id INTEGER NOT NULL ,
	semester INTEGER NOT NULL,
	audience VARCHAR(10) NOT NULL,
	start_time VARCHAR(5) NOT NULL,
	FOREIGN KEY (professors_id)  REFERENCES professors(id),
	FOREIGN KEY (group_id) REFERENCES groups(id),
	FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

--напишем функцию, которая будет вычислять количество записей для определенного преподавателя
CREATE OR REPLACE FUNCTION add_to_prof()
RETURNS TRIGGER AS $$
DECLARE 
id1 integer;
iid integer;
count integer;
newcount integer;
count2 integer;
newcount2 integer;
BEGIN 
IF TG_OP = 'INSERT' THEN 
id1 := NEW.professors_id;
SELECT classes FROM professors p INTO count WHERE p.id = id1;  --count := (SELECT classes FROM professors p WHERE p.id = id);
newcount := count + 1;
UPDATE professors p SET classes = newcount WHERE p.id = id1;
RETURN NEW;
ELSIF TG_OP = 'UPDATE'
THEN
id1 = OLD.professors_id;
iid = NEW.professors_id;
IF id1 <> iid THEN
count = (SELECT classes FROM professors p WHERE p.id = id1);
newcount = count - 1;
count2 = (SELECT classes FROM professors p WHERE p.id = iid);
newcount2 = count2 + 1;
UPDATE professors p SET classes = newcount WHERE p.id = id1;
UPDATE professors p SET classes = newcount2 WHERE p.id = iid;
END IF;
RETURN NEW;
ELSEIF TG_OP='DELETE' THEN
id1 = OLD.professors_id;
count = (SELECT classes FROM professors p WHERE p.id = id1);
newcount = count - 1;
UPDATE professors p  SET classes = newcount WHERE p.id = id1;
RETURN OLD;
END IF;
END;
 $$ LANGUAGE plpgsql;

 --она понадобится нам для триггера
 CREATE TRIGGER t_classes
AFTER INSERT OR UPDATE OR DELETE ON classes FOR EACH ROW EXECUTE PROCEDURE add_to_prof();

/* теперь каждый раз, когда в таблицу занятий будут добавлять/изменять/удалять запись
наш триггер будет вызывать функцию, которая при каждом определенном дейтствии будет изменять
запись преподавателя в таблице профессоров.
Для примера посмотрим таблицу профессоров сейчас, у всех в поле нагрузка стоит 0 */

SELECT *
FROM professors_ns;

--добавим данные для таблицы занятия
INSERT INTO classes (professors_id, group_id, subject_id, semester, audience, start_time)
 VALUES (5, 23, 1, 5, '1111', '17:00');

--cнова взглянем на таблицу профессоров. Она изменилась, теперь поле нагузка стало вычислимым)
SELECT *
FROM professors_ns;

INSERT INTO classes (professors_id, group_id, subject_id, semester, audience, start_time)
 VALUES (1, 19, 2, 5, '910', '15:20'), (6, 19, 3, 5, '905', '18:40'), (6, 19, 3, 5, '1111', '13:35'),
  (4, 19, 5, 5, '1008', '10:10'),(4, 19, 6, 5, '909', '08:30'), (3, 19, 8, 4, '905', '10:10'), 
  (3, 19, 9, 5, '910', '10:10'), (14, 19, 7, 5, '1008', '13:35');

CREATE VIEW Prof_clas AS SELECT p.surname, p.name,p.id, c.subject_id, c.group_id,c.audience, c.start_time 
FROM classes c INNER JOIN professors_ns p
 ON (p.id = c.professors_id);


CREATE VIEW Prof_clas AS SELECT p.id, p.name, p.surname, 
c.id_subject, c.semestr, s.audiense, c.start_time
FROM classes c INNER JOIN (SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person) p
 ON (p.id = c.professors_id);

--таблица код профессора, имя и фамилия.
SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person;

--таблица код занятия, код предмета, наименование предмета, леция/практика, 
--код профессора, который ведет занятие, семестр, аудитория, время начала занятия.
SELECT c.id AS classes_id, sub.id AS subject_id, name AS subject_name,
subject_type, c.professors_id, c.semester, c.audience, c.start_time
FROM classes c, subjects sub
WHERE c.subject_id = sub.id;


--представление, с помощью которого можно узнать подробные данные о преподавателе и о занятии, которое он ведет
CREATE VIEW Prof_clas AS SELECT p.id, p.name, p.surname, c.group_id
, c.subject_name, c.subject_type, c.semester, c.audience, c.start_time
FROM (SELECT c.id AS classes_id, sub.id AS subject_id, c.group_id, name AS subject_name,
subject_type, c.professors_id, c.semester, c.audience, c.start_time
FROM classes c, subjects sub
WHERE c.subject_id = sub.id) c INNER JOIN (SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person) p
 ON (p.id = c.professors_id);

Select *
From Prof_clas
WHERE semester = 5 AND group_id = 19
ORDER BY start_time;

--представление, с помощью которого можно узнать подробные данные о преподавателе и о занятии, которое он ведет и о группе
CREATE VIEW Prof_clas_group AS SELECT  p.name, p.surname, g.group_number, 
p.subject_name, p.subject_type, p.semester, p.audience, p.start_time
FROM Prof_clas p INNER JOIN groups g
ON (p.group_id = g.id);



 Вывести список студенток, прослушавших определенный курс(Базы Данных) в 5 семестре 
•	фамилия студента
•	код группы
•	наименование предмета
•	количество часов
•	вид (лекция\практика)

-- имя и фамилия студентки, код группы, в которой она учится
SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж';



--имя и фамилия студентки, код группы, код предмета, семестр
SELECT st.name, st.surname, c.group_id, c.subject_id, c.semester
FROM classes c INNER JOIN (SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж') st
ON c.group_id = st.group_id
WHERE c.semester = 5;

--окончательная таблица
SELECT  st.name, st.surname, st.group_id,
 sub.name, sub.hours, sub.subject_type,  st.semester
FROM subjects sub INNER JOIN
(SELECT st.name, st.surname, c.group_id, c.subject_id, c.semester
FROM classes c INNER JOIN (SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж') st
ON c.group_id = st.group_id
WHERE c.semester = 5) st
ON sub.id = st.subject_id
WHERE sub.name ILIKE 'Базы Данных';


/*Найти и вывести список студентов, прослушавших все курсы, которые читаются  некоторым преподавателем
1)Узнать, какие курсы вел конкретный преподаватель
2)Узнать, какие группы были на каждом из этих курсов
3)Список студентов, состоящих в каждой группе

*/

CREATE OR REPLACE FUNCTION two (idd integer)
  RETURNS TABLE(name VARCHAR, surname VARCHAR ) AS 
$BODY$ 
 DECLARE
 rec RECORD;
 i integer;
BEGIN
i := (SELECT  group_id
FROM prof_clas p_c
WHERE p_c.id= idd);

FOR rec IN EXECUTE 'SELECT p.name, p.surname
FROM persons p INNER JOIN (SELECT id_person
FROM students 
WHERE group_id = i) pp
ON (p.id = pp.id_person)'
	LOOP
		name = rec.name;
		surname =rec.surname;
		
		RETURN next;
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION two(idd integer) OWNER TO postgres;

SELECT *
FROM two(5) ;

DROP FUNCTION two (idd integer);


/*
Таблица 5_1. СТУДЕHТЫ (объединенные в гpуппы)
* Код студента
* Фамилия студентаppp
* Пол
* Код группы
* Населенный пункт проживания

Таблица 5_2. ПРЕПОДАВАТЕЛИ
* Код преподавателя
* Фамилия преподавателя
* Факультет
* Общая реальная нагрузка преподавателя(связать с таблицей занятия )
* Кафедра


Таблица 5_3. ПРЕДМЕТЫ
* Код предмета
* Наименование предмета* Вид отчетности (зачет, экзамен, курсовая)
лекция или практика
* Количество часов

Таблица 5_4. ЗАHЯТИЯ (КТО, ЧТО, КОМУ - гpуппе, КОГДА, ГДЕ)
* Код преподавателя
* Код группы
* Код предмета
* Семестр
* Аудитория
* Время

ФАЙЛ5_5. ГРУППЫ
* Код группы
* Номер группы
* Число студентов в группе
* Факультет
* Староста


		Найти и вывести список студентов, прослушавших все курсы, которые читаются  некоторым преподавателем
	3) 	Найти и вывести для каждого студента 
•	фамилия студента
•	общая часовая нагрузка в 3 семестре

*/
