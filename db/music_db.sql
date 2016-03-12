$ sudo -u postgres dropdb database
$ sudo -i -u postgres -- -i=--login -u=--user
$ createdb manufacture
$ dropdb manufacture
$ psql music
$ psql -l --показ всех баз

\l - список баз данных.
\dt - список всех таблиц.
\d table - структура таблицы table.
\du - список всех пользователей и их привилегий.
\dt+ - список всех таблиц с описанием.
\dt *s* - список всех таблиц, содержащих s в имени.
\i FILE - выполнить команды из файла FILE.
\o FILE - сохранить результат запроса в файл FILE.
\a - переключение между режимами вывода: с/без выравнивания.

CREATE TABLE Genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL
);

CREATE INDEX Genres_id ON Genres(id);

DELETE FROM Genres;
INSERT INTO Genres (name) Values ('Rap & Hip-Hop'), ('Pop'), ('Classical'), ('New Age'), ('Rock');

SELECT * FROM Genres
	ORDER BY id ASC;

UPDATE Genres 
	SET name = 'Hip-Hop'
	WHERE id = 1;

SELECT * FROM Genres
	ORDER BY id ASC;

SELECT name
	FROM Genres
	WHERE name LIKE 'Hip-Hop';

CREATE TABLE Countries (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL 
);

INSERT INTO Countries (name) Values ('United States'), ('Russia'), ('Great Britain'), ('Australia');

SELECT * FROM Countries;

CREATE TYPE GENDER AS ENUM ('М', 'Ж');

CREATE TABLE Persons (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	birthday DATE NOT NULL,
	gender GENDER NOT NULL
);

CREATE INDEX Person_id ON Persons(id);

INSERT INTO Persons (first_name, last_name, birthday, gender) 
VALUES ('Drake', 'Graham', '24-10-1986', 'М'), ('Вася', 'Вакуленко', ' 20-04-1980 ', 'М'), 
('John', 'Lennon', '9-10-1940', 'М'), ('Ella', 'Lani', '7-11-1996', 'Ж');

CREATE TABLE Artists ( 
	id SERIAL PRIMARY KEY,
	pseudonym VARCHAR UNIQUE,
	person_id INTEGER NOT NULL,
	country_id INTEGER NOT NULL,
	FOREIGN KEY (person_id) REFERENCES Persons(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (country_id) REFERENCES Countries(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO Artists (pseudonym, person_id, country_id) VALUES ('Drake', 1, 1), ('Баста', 2, 2), 
('John Lennon', 3, 3), ('Lorde', 4, 4), ('Ноггано', 2, 2);

CREATE TABLE Groups (
	id SERIAL PRIMARY KEY,
	group_name VARCHAR
);

INSERT INTO Groups (group_name) VALUES ('The Beatles');

CREATE TABLE Artists_to_groups (
	group_id INTEGER NOT NULL,
	artist_id INTEGER NOT NULL,
	FOREIGN KEY (group_id) REFERENCES Groups(id) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN KEY (artist_id) REFERENCES Artists(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Artists_to_groups VALUES (1, 1), (1, 2);

CREATE VIEW Groups_artists AS 
	SELECT a.pseudonym, g.group_name 
	FROM Artists_to_groups ag
	INNER JOIN Artists a ON (a.id = ag.artist_id)
	INNER JOIN Groups g ON (g.id = ag.group_id)

SELECT a.pseudonym, g.group_name 
	FROM Artists_to_groups ag
	INNER JOIN Artists a ON (a.id = ag.artist_id)
	INNER JOIN Groups g ON (g.id = ag.group_id)
	WHERE g.group_name LIKE 'Drake';

SELECT * FROM Groups_artists;

CREATE TABLE Albums (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER,
	group_id INTEGER,
	genre_id INTEGER NOT NULL,
	title VARCHAR NOT NULL,
	year DATE NOT NULL,
	number_tracks INTEGER DEFAULT 0,
	FOREIGN KEY (artist_id) REFERENCES Artists(id),
	FOREIGN KEY (group_id) REFERENCES Groups(id),
	FOREIGN KEY (genre_id) REFERENCES Genres(id),
	CHECK (number_tracks >= 0),
	CHECK ((artist_id IS NOT NULL AND group_id IS NULL) OR (artist_id IS NULL AND group_id IS NOT NULL))
);

INSERT INTO Albums (artist_id, group_id, genre_id, title, year, number_tracks) 
VALUES 
	(1, NULL, 1, 'If You’re Reading This It’s Too Late', '13-2-2015', DEFAULT), 
	(2, NULL, 1, 'Баста 4', '14-5-2013', 17), 
	(NULL, 1, 5, 'Imagine', '9-9-1971', 10), 
	(4, NULL, 2, 'Pure Heroine', '27-9-2013', 15);

INSERT INTO Albums (artist_id, group_id, genre_id, title, year, number_tracks) 
VALUES (1, 1, 1, 'If You’re Reading This It’s Too Late', '13-2-2015', DEFAULT);

CREATE TABLE Songs (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER,
	group_id INTEGER,
	album_id INTEGER, 
	genre_id INTEGER,
	title VARCHAR NOT NULL,
	duration INTEGER NOT NULL,  --в секундах 
	track_no SMALLINT, 
	FOREIGN KEY (artist_id) REFERENCES Artists(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (group_id) REFERENCES Groups(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (album_id) REFERENCES Albums(id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (genre_id) REFERENCES Genres(id) ON UPDATE CASCADE ON DELETE SET NULL,
	CHECK ((artist_id IS NOT NULL AND group_id IS NULL) OR (artist_id IS NULL AND group_id IS NOT NULL))
);

INSERT INTO Songs (artist_id, group_id, album_id, genre_id, title, duration, track_no) VALUES 
(4, NULL, 4, 2, 'Royals', 188, 3);
INSERT INTO Songs (artist_id, album_id, genre_id, title, duration, track_no) VALUES (1, 1, 1, 'Over', 188, 3);

CREATE VIEW Artists_persons AS
	SELECT g.name AS genre, c.name AS country, p.first_name, p.last_name, p.birthday, p.gender
	FROM Artists a 
	INNER JOIN Genres g ON (g.id = a.genre_id)
	INNER JOIN Countries c ON (c.id = a.country_id)
	INNER JOIN Persons p ON (p.artist_id = a.id);

CREATE VIEW Artists_albums AS
	SELECT al.title, al.year, CONCAT(p.first_name, ' ', p.last_name) AS artist
	FROM Artists a
	INNER JOIN Albums al ON (al.artist_id = a.id)
	INNER JOIN Persons p ON (p.artist_id = a.id);

CREATE OR REPLACE FUNCTION add_songs()
RETURNS TRIGGER AS $$
DECLARE 
	count INTEGER;
BEGIN 
	IF TG_OP = 'INSERT' THEN 
		SELECT number_tracks FROM Albums INTO count WHERE id = NEW.album_id;
		UPDATE Albums SET number_tracks = count + 1 WHERE id = NEW.album_id;
	RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF OLD.album_id <> NEW.album_id THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = NEW.album_id) + 1) 
		WHERE id = NEW.album_id;
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
		END IF;
		IF OLD.album_id IS NULL THEN
		UPDATE Albums SET number_tracks = number_tracks + 1
		WHERE id = NEW.album_id;
		END IF;
		IF NEW.album_id IS NULL THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
		END IF;
	RETURN NEW;
	ELSEIF TG_OP = 'DELETE' THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
	RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_songs
AFTER INSERT OR UPDATE OR DELETE ON Songs FOR EACH ROW EXECUTE PROCEDURE add_songs();

SELECT s.title, g.name
	FROM Songs s INNER JOIN Genres g ON (s.genre_id = g.id);

UPDATE Albums
	SET number_tracks = 1
	WHERE id = 1;
























SELECT DISTINCT Artists_genre(genre_id) AS count
FROM Artists;

CREATE VIEW Artists_persons2 AS
	SELECT g.name AS genre, c.name AS country, p.first_name, p.last_name, p.birthday, p.gender, a.id
	FROM Artists a 
	INNER JOIN Genres g ON (g.id = a.genre_id)
	INNER JOIN Countries c ON (c.id = a.country_id)
	INNER JOIN Persons p ON (a.person_id = p.id);
 
CREATE VIEW Albums2 AS 
SELECT a.title, s.genre_id 
	FROM Albums a
	INNER JOIN Songs s ON (a.id = s.album_id);

SELECT al.title, g.name
	FROM Albums2 al
	INNER JOIN Genres g ON (al.genre_id = g.id);

CREATE VIEW Artists_genre AS
	SELECT ap.first_name, ap.last_name, g.name 
	FROM Artists_persons INNER JOIN 

SELECT ap.genre, ap.first_name, ap.last_name, a.id
	FROM Artists_persons2 ap INNER JOIN Artists a ON (a.id = ap.id)
	WHERE ap.genre = 'Hip-Hop';

SELECT a.title AS album_title, CONCAT(ap.first_name, ' ', ap.last_name) AS artist, a.id
	FROM Artists_persons2 ap INNER JOIN Albums a ON (a.artist_id = ap.id)
	WHERE ap.genre = 'Hip-Hop';

SELECT a.title AS album_title, CONCAT(ap.first_name, ' ', ap.last_name) AS artist, a.number_tracks
	FROM Artists_persons2 ap INNER JOIN Albums a ON (a.artist_id = ap.id)
	WHERE ap.genre = 'Hip-Hop'
	LIMIT 3 OFFSET 0;

INSERT INTO Songs (title, duration, album_id, track_no) VALUES ('Over', 180, 1, 3);

UPDATE Albums 
	SET number_tracks = 0
	WHERE id = 1;

SELECT g.name
	FROM Genres g INNER JOIN Artists_persons2 ap ON (g.name = ap.genre)
	GROUP BY g.name
	HAVING COUNT(*) > 1;

DROP TABLE IF EXISTS Artists CASCADE;