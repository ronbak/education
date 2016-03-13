CREATE DATABASE education_g;

CREATE TYPE GENDER AS ENUM ('М', 'Ж');

-- UNIQUE, CHECK, NOT NULL, ON [UPDATE/DELETE] [CASCADE, RESTRICT]

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	gender GENDER NOT NULL, --пол
	group_id INTEGER NOT NULL,
	location VARCHAR(50) NOT NULL DEFAULT 'Казань', --населенный пункт проживания
	CHECK (group_id >= 1)
);

INSERT INTO students VALUES ('1','Гульнара', 'Нигматзянова', 'Ж', '2', DEFAULT);
INSERT INTO students (name, surname, gender, group_id, location) VALUES ('Эмиль', 'Атажанов', 'М', '2', 'Астана'), ('Илюза', 'Сакаева', 'Ж', '1', 'Уфа');

CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	group_no VARCHAR(10) NOT NULL, --номер группы
	student_quantity INTEGER NOT NULL, --количество студентов
	faculty VARCHAR(50) NOT NULL, --факультет
	steward INTEGER NOT NULL,
	FOREIGN KEY (steward) REFERENCES students(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO groups VALUES ('1', '1', 10, 'ИВМиИТ', 3);
INSERT INTO groups VALUES ('2', '2', 10, 'ИВМиИТ', 1);
ALTER TABLE students ADD CONSTRAINT stud_group FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT g.group_no, g.student_quantity, g.faculty, s.name, s.surname FROM students s INNER JOIN groups g ON (s.id = g.steward);

CREATE VIEW Stewards AS SELECT g.group_no, g.student_quantity, g.faculty, s.name, s.surname FROM students s INNER JOIN groups g ON (s.id = g.steward);
SELECT * FROM Stewards;

CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	surname VARCHAR(50) NOT NULL,
	faculty VARCHAR(50) NOT NULL, --факультет
	classes INTEGER NOT NULL REFERENCES classes(id), --че?
	department VARCHAR(50) NOT NULL --кафедра	
);

CREATE TYPE REPORT_TYPE AS ENUM ('Зачет', 'Экзамен', 'Курсовая');
CREATE TYPE SUBJECT_TYPE AS ENUM ('Лекция', 'Практика');

CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	report_type REPORT_TYPE NOT NULL,
	subject_type SUBJECT_TYPE NOT NULL,
	hours INTEGER NOT NULL
);

CREATE TABLE classes (
	id SERIAL PRIMARY KEY,
	teacher_id INTEGER NOT NULL UNIQUE REFERENCES teachers(id),
	group_id INTEGER NOT NULL,
	subject_id INTEGER NOT NULLUNIQUE ,
	semester INTEGER NOT NULL,
	audience VARCHAR(10) NOT NULL,
	start_time VARCHAR(5) NOT NULL,
	FOREIGN KEY (group_id) REFERENCES groups(id),
	FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

/*
Таблица 5_1. СТУДЕHТЫ (объединенные в гpуппы)
* Код студента
* Фамилия студента
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
* Наименование предмета
* Вид отчетности (зачет, экзамен, курсовая)
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
*/