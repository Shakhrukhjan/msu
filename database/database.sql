
CREATE DATABASE msu;
DROP DATABASE msu;
DROP DATABASE postgres;
ALTER DATABASE postgres RENAME TO msu;
-------------------------- Таблица Факультеты -----------------------------------------------------------------------------

CREATE TABLE faculties(
                             id SERIAL PRIMARY KEY,
                             name    VARCHAR NOT NULL,
                             dekan   VARCHAR NOT NULL
 );

SELECT s.Id, s.Fio , s.Record_Number, d.Number, s.Birth_Date, s.City, s.Number_Phone, s.Scholarship FROM students AS s, groups AS d WHERE s.Number = d.Id
drop table faculties;
select *from faculties;

update faculties set dekan = 'Салимова Санавбар Салимовна' where id = 2;

SELECT c.Id, c.Number, f.Name, c.Year_Creat FROM faculties AS f, groups as c WHERE c.FacultyId=f.Id;
INSERT INTO faculties(Name, Dekan) VALUES('Естественнонаучный факультет', 'Назриева Мунирова Мухиддиновна');
INSERT INTO faculties(Name, Dekan) VALUES('Гуманитарный факультет', 'Назриева Мунирова Мухиддиновна');
select  s.id, s.number, f.name , s.year_creat from groups as s, faculties as f  where s.faculty_id=f.Id;

-------------------------- Таблица Группы -----------------------------------------------------------------------------

CREATE TABLE GROUPS(
            id         SERIAL PRIMARY KEY,
            number     VARCHAR NOT NULL,
            facultyId  INTEGER REFERENCES faculties(Id),
            yearCreat  VARCHAR
);

INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('ПМиИ', 1, '12.09.2020');
INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('МО', 2, '01.03.2020');
INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('ХФММ', 1, '01.10.2021');
INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('Лингвистика', 2, '03.03.2020');
INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('Геология', 1, '01.03.2020');
INSERT INTO groups(Number, FacultyId, YearCreat) VALUES('ГМУ', 2, '02.11.2020');

SELECT c.Id, c.Number, f.Name, c.YearCreat
FROM faculties AS f, groups AS  c
WHERE c.FacultyId = f.Id;


-------------------------- Таблица Стипендии -----------------------------------------------------------------------------

CREATE TABLE scholarship (
                             Id  SERIAL PRIMARY KEY ,
                             Category    VARCHAR NOT NULL,
                             Discription VARCHAR NOT NULL,
                             Summa       varchar   NOT NULL
);

INSERT INTO scholarship(Category,Discription, Summa) VALUES('категория 1','Студенты, учащиеся только на 4', '270 сом');
INSERT INTO scholarship(Category,Discription, Summa) VALUES('категория 2','Студенты, учащиеся на 4 и 5', '295 сом');
INSERT INTO scholarship(Category,Discription, Summa) VALUES('категория 3','Студенты, учащиеся только на 5', '320 сом');
INSERT INTO scholarship(Category,Discription, Summa) VALUES('соц','Студенты, получащиеся социальную стипендию', '500 сом');
INSERT INTO scholarship(Category,Discription, Summa) VALUES('Не оформлена','Студенты, не получащиеся стипендию', '0');

update scholarship set Category = '270 cомони' where id = 1;
update scholarship set Category = '295 cомони' where id = 2;
update scholarship set Category = '320 cомони' where id = 3;
update scholarship set Category = '500 cомони' where id = 4;

SELECT * FROM scholarship;
DROP TABLE scholarship;
SELECT s.id, s.fio, s.record_number, d.number, s.kurs, to_char(s.birth_date,'DD.MM.YYYY') as "birth_date", s.city, s.number_Phone, ss.summa  FROM students AS s, groups AS d, scholarship as ss  WHERE s.number = d.id and s.scholarship = ss.id ORDER BY id;-------------------------------------------------------- Таблица Студенты ---------------------------------------------------------


CREATE TABLE students (
                          Id            SERIAL PRIMARY KEY ,
                          Fio           VARCHAR NOT NULL,
                          Record_Number  INT     NOT NULL CHECK (Record_Number > 0),
                          Number       INTEGER REFERENCES groups(Id),
                          Birth_Date     DATE    NOT NULL,
                          City          VARCHAR NOT NULL,
                          Number_Phone   VARCHAR NOT NULL,
                          Scholarship   INTEGER references scholarship(Id)
);
drop table students;
INSERT INTO Students VALUES(1,'Абдуазимов Сафарали Музаффарович',     235454, 1 , '27.06.2003', 'г.Шахристан', 992937030201, 5);
INSERT INTO Students VALUES(2,'Ахатзода Техроншох Абдухабиб',         235454, 1 , '27.06.2002', 'г.Дангара', 992937203020, 5);
INSERT INTO Students VALUES(3,'Бекмамадов Ромиз',                     235454, 2 , '12.01.2002', 'г.Куляб', 992918209732, 5);
INSERT INTO Students VALUES(4,'Бобизода Мухсин',                      112212, 2 , '21.01.2002', 'г.Душанбе', 992987654345, 5);
INSERT INTO Students VALUES(5,'Ахрорзода Шохрух Ахрор',               453455, 1, '26.03.2002', 'г.Ахшабад', 992918252634, 5);
INSERT INTO Students VALUES(6,'Аьламов Сафарали Музаямович',          436756, 2,'06.01.2001', 'г.Дангара', 992987584857, 5);
INSERT INTO Students VALUES(7,'Джумаев Бехзод Джасурбоевич',          234257, 3,'14.06.2002', 'г.Куляб', 992985857584, 5);
INSERT INTO Students VALUES(8,'Ерахмадов Джавохир Наимджонович',      399158, 2,'23.01.2000', 'г.Бадахшан', 992918251425, 5);
INSERT INTO Students VALUES(9,'Ильясова Анисабону Абдувохидовна',     222259, 1,'11.03.2002', 'г.Душанбе', 992906262425, 5);
INSERT INTO Students VALUES(10,'Кавраков Шавкат Азизджонович',        234960, 3,'17.01.2002', 'г.Дангара', 992905263635, 5);
INSERT INTO Students VALUES(11,'Кенджабоев Далер Дилшодович',         234561, 2,'24.03.2001', 'г.Душанбе', 992918254785, 5);
INSERT INTO Students VALUES(12,'Муддинов Мухаммади Тоджидинович',     234562, 4,'12.12.2002', 'г.Москва', 992907586947, 5);
INSERT INTO Students VALUES(13,'Наджмиддинов Шахзоджон Озоджонович',  211563, 5,'18.11.2002', 'г.Дангара', 992903253614, 5);
INSERT INTO Students VALUES(14,'Назаров Икбол Сайидович',             234764, 4,'27.10.2001', 'г.Фуркан', 992985758468, 5);
INSERT INTO Students VALUES(15,'Одинаев Икромиддин Олимхонович',      285965, 2,'23.05.2002', 'г.Муминабад', 992900253600, 5);
INSERT INTO Students VALUES(16,'Рахматов Абдуллох Шералиевич',        278466, 2,'18.07.2002', 'г.Душанбе', 992900253601, 5);
INSERT INTO Students VALUES(17,'Темурбекова Гулабру Карамалиевна',    748567, 1,'14.08.2002', 'г.Душанбе', 992918252634, 5);
INSERT INTO Students VALUES(18,'Хокимзода Муборакшои Иноятулло',      589668, 6,'12.09.2002', 'г.Душанбе', 992918252624, 5);

UPDATE students SET scholarship = 3 WHERE fio = 'Ахрорзода Шохрух Ахрор';

SELECT s.Id, s.Fio , s.Record_Number, d.Number, s.Birth_Date, s.City, s.Number_Phone, ss.Category
FROM students AS s, groups AS d, scholarship as ss
WHERE s.Number = d.Id and s.scholarship = ss.Id;
SELECT *FROM students;
ALTER TABLE students RENAME COLUMN RecordNumber TO Number_Record;
ALTER TABLE students ALTER COLUMN BirthDate TYPE VARCHAR;

-------------------------- Таблица Предметы -----------------------------------------------------------------------------------------------
select *from students;

CREATE TABLE subjects
(
    Id       SERIAL PRIMARY KEY,
    Student_Id integer references students(Id),
    Name     VARCHAR NOT NULL,
    Semester INTEGER CHECK (Semester > 0 and Semester < 9),
    Types    VARCHAR NOT NULL,
    Grade    INTEGER
);
select * from subjects;
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Практический курс на ЭВМ', 6,'зачет', 0 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Теория игр и исследов операции', 6, 'зачет', 0 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(1, 'Прикладные интернет технологии', 6, 'зачет', 1);


INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Практический курс на ЭВМ', 6,'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Теория игр и исследов операции', 6, 'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(2, 'Прикладные интернет технологии', 6, 'зачет', 1);


INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Практический курс на ЭВМ', 6,'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Теория игр и исследов операции', 6, 'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Информ банк технологии', 6, 'экзамен', 3);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(3, 'Прикладные интернет технологии', 6, 'зачет', 1);


INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Практический курс на ЭВМ', 6,'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Компютерные сети', 6, 'экзамен', 3);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Офисные технологии', 6, 'зачет', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Теория игр и исследов операции', 6, 'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(4, 'Прикладные интернет технологии', 6, 'зачет', 1);


INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Практический курс на ЭВМ', 6,'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Теория игр и исследов операции', 6, 'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(5, 'Прикладные интернет технологии', 6, 'зачет', 1);
---------------------------------------------------------------------------------------------------------------------------------

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Практический курс на ЭВМ', 6,'зачет', 1 );
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(6, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(7, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Теория игр и исследов операции', 6, 'зачет', 0);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(8, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(9, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(10, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(11, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(12, 'Прикладные интернет технологии', 6, 'зачет', 0);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(13, 'Прикладные интернет технологии', 6, 'зачет', 0);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(14, 'Прикладные интернет технологии', 6, 'зачет', 0);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(15, 'Прикладные интернет технологии', 6, 'зачет', 0);
select  *from subjects;
SELECT  p.id, s.fio, p.name, p.semester, p.types, p.grade  FROM students AS s, subjects AS p WHERE p.student_id = s.id;
UPDATE subjects SET  student_id = $2, semester = $3,  types = $4, grade = $5  where id = $6
    INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(16, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(17, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Компютерные сети', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(18, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Практический курс на ЭВМ', 6,'зачет',1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(19, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Практический курс на ЭВМ', 6,'зачет',4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Системное и ПИТ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Информ банк технологии', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(20, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Практический курс на ЭВМ', 6,'зачет',5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(21, 'Прикладные интернет технологии', 6, 'зачет', 0);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Практический курс на ЭВМ', 6,'зачет',5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Функциональный анализ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(22, 'Прикладные интернет технологии', 6, 'зачет', 0);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Практический курс на ЭВМ', 6,'зачет',5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(23, 'Прикладные интернет технологии', 6, 'зачет', 1);


INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Практический курс на ЭВМ', 6,'зачет',5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Операционные системы', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(24, 'Прикладные интернет технологии', 6, 'зачет', 1);

INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Практический курс на ЭВМ', 6,'зачет',4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Компютерные сети', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Офисные технологии', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Операционные системы', 6, 'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Функциональный анализ', 6,'экзамен', 4);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Системное и ПИТ', 6,'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Теория игр и исследов операции', 6, 'зачет', 1);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Информ банк технологии', 6, 'экзамен', 5);
INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES(25, 'Прикладные интернет технологии', 6, 'зачет', 1);

CREATE TABLE transactions(
    id serial primary key,
     summa integer,
    date varchar
);
drop table transactions;
INSERT INTO transaction(category, summa, date) VALUES (1, 250, '12.12.2023');
select * from students;
select t.id, s.Category, t.summa, t.date from transaction as t, scholarship as s  where  t.id = s.Id;
update students set kurs=3 where id = 9;

ALTER TABLE students ADD COLUMN kurs INTEGER;

CREATE TABLE users (
    id bigserial primary key,
    name varchar(100), 
    email varchar(100) unique ,
    password varchar(50),
    created timestamp not null default current_timestamp
);
drop table users;
drop table users_tokens;
create table users_tokens (
    user_id bigint not null references users ,
    created timestamp not null default current_timestamp
);
drop table users_tokens;
select *from users;
select *from users_tokens;
SELECT id, password FROM users WHERE email = 'shakhrukhjane@gmail.com';
