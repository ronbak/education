CREATE OR REPLACE FUNCTION random_string(lengh integer)
RETURNS varchar AS $$
  SELECT array_to_string(ARRAY(
          SELECT substr('abcdefghijklmnopqrstuv',trunc(random()*21+1)::int,1)
             FROM generate_series(1,$1)),'')
$$ LANGUAGE sql VOLATILE;

CREATE OR REPLACE FUNCTION loop (n int) RETURNS VOID AS
$$ DECLARE
x int;
BEGIN
FOR i IN 1..n LOOP
x := trunc(random()*21+1);
INSERT INTO TEST_int(x) VALUES (x);
END LOOP;
END;
$$
LANGUAGE 'plpgsql';

select trunc(random()*21); --random() -случайное 0.0 < x < 1.0, trunc() - округление до целого;

CREATE OR REPLACE FUNCTION array_ap (lengh int) RETURNS VOID AS
$$ DECLARE
x int;
s varchar;
array varchar[];
BEGIN
s := 'abcdefghijklmnopqrstuv';
FOR i IN 1..lengh LOOP

END LOOP;


CREATE OR REPLACE FUNCTION datagenerator (lengh int) RETURNS VOID AS
$$ DECLARE
x int;
s varchar;
s1 varchar;
array varchar[];
BEGIN
s:='abcdefghijklmnopqrstuv';
FOR i IN 1..n LOOP
x:=trunc(random()*21+1);
SELECT substring(s from x for 1) INTO s1;
array:=array_append(array, s1);
INSERT INTO TEST(first_name) VALUES (array_to_string(array));
END LOOP;
END;
$$
LANGUAGE 'plpgsql';

CREATE TABLE test_table1 (
  x INT,
  y INT,
  s1 VARCHAR,
  s2 VARCHAR
);

CREATE TABLE test_table2 (
  x INT,
  y INT,
  s1 VARCHAR,
  s2 VARCHAR
);

CREATE TABLE test_table3 (
  x INT,
  y INT,
  s1 VARCHAR,
  s2 VARCHAR
);

CREATE OR REPLACE FUNCTION loop(n int) RETURNS VOID AS
$$ DECLARE
x int;
y int;
e int;
s varchar;
s1 varchar;
s2 varchar;
array1 varchar[];
array2 varchar[];
BEGIN
    s:='abcdefghijklmnopqrstuv';
    FOR i IN 1..n LOOP
        x := trunc(random()*100);
        y := trunc(random()*100);
        FOR j IN 1..5 LOOP
            e := trunc(random()*21+1);
            SELECT substring(s from e for 1) INTO s1;
            e := trunc(random()*21+1);
            SELECT substring(s from e for 1) INTO s2;
            array1:=array_append(array1, s1);
            array2:=array_append(array2, s2);
        END LOOP;
        s1 := array_to_string(array1,'');
        s2 := array_to_string(array2,'');
        INSERT INTO test_table1(x, y, s1, s2) VALUES (x, y, s1, s2);
        array1 := '{NULL}';
        array2 := '{NULL}';
        s1 := ' ';
        s2 := ' ';
        --INSERT INTO test_table2(x, y, s1, s2) VALUES (x, y, s1, s2);
        --INSERT INTO test_table3(x, y, s1, s2) VALUES (x, y, s1, s2);
    END LOOP;
END;
$$
LANGUAGE 'plpgsql';

SELECT * from loop(5);
