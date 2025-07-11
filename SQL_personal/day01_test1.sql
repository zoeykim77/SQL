--실습--
--문제1 DDL
CREATE DATABASE practice;
SHOW DATABASES;

USE practice;

--문제2 DDL, 오답 : 자동증가 제약도 추가 
CREATE TABLE student(student_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(20) NOT NULL, grade INT);
--자동키증가 누락 AURO_INCREMENT
SHOW TABLES;
DESC student;

--문제3 DML 삽입, 오답: 자동증가는 id int 일일히 넣지않는다. 
INSERT INTO student(student_id, name, grade)
VALUES (1,'홍길동',3),
        (2,'김철수',2),
        (3,'박병철',1),
        (4,'안새싹',3);

SELECT *
FROM student;


--문제4 DML 수정, 
UPDATE student
SET grade=4
WHERE student_id = 4;

SELECT *
FROM student;

--문제5 DML 특정행기준 삭제
DELETE FROM student
WHERE grade=2;

SELECT *
FROM student;