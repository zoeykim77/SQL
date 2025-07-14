-- Active: 1752194083940@@127.0.0.1@3306@lecture

---DDL
--데이터베이스 목록 확인
SHOW DATABASES;

--데이터베이스 사용하기
USE lecture;

--테이블 목록 확인하기 

SHOW TABLES;

-- 테이블 살펴보기 

DESC user_info;

--테이블 삭제 
--DROP TABLE IF EXISTS user_info;
--SHOW TABLES;

--테이블 생성
CREATE TABLE users(
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
    );

SHOW TABLES;

-- 기본적인 테이블 생성
CREATE TABLE students (
    student_id VARCHAR(7) PRIMARY KEY,
    name VARCHAR(10),
    grade INT, 
    major VARCHAR(20)
);


-- 외래키가 있는 테이블 생성
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(7) REFERENCES students(student_id),
    date DATE,
    status VARCHAR(10)
);

SHOW TABLES;

--데이터 수정 ALTER, 테이블의 열 추가
ALTER TABLE users
ADD phone VARCHAR(20) NOT NULL;

ALTER TABLE users
MODIFY phone VARCHAR(20);

--전체 테이블 확인 DESC (어떤 열들 있는지)
DESC users;

SHOW TABLES;


-- 데이터 삭제 DROP & IF 조건은 오류 안보고 싶을때! 
-- TABLE 전체 삭제 
DROP TABLE IF EXISTS attendance;

SHOW TABLES;

RENAME TABLE users
TO users_info;

SHOW TABLES;


-----DML
--DML은 크게 CRUD(Create, Read, Update, Delete) 기능을 수행하는 명령어
--데이터의 '값'을 어떻게 다루느냐 

--데이터 '값' 추가 INSERT

INSERT INTO users_info(user_id, name)
VALUES (1, 'alex'),
        (2, 'jun'),
        (3, 'chelsea');
--1개의 소괄호는 1행, ',' 및 ';' 잘 보기 

SELECT *
FROM users_info;
--DML의 확인하기는 SELECT *

INSERT INTO users_info
VALUES (4, 'ken', 'ken@example.com',''),
        (5, 'hailey', 'hailey@google.com', '010-000-0000');
--별도 칼럼 지정 안해도 자연스럽게 추가됨 


--데이터 조회 (SELECT) : SQL을 잘다루는 것은 SELECT 문 다루는 것에! 
SELECT *
FROM users_info;

--데이터 수정 (UPDATE)
--조건대로 수정 필요, SET 및 WHERE 
--DDL 에서는 ALTER로 테이블의 열을 추가 등 ! 

UPDATE users_info
SET email = 'chelsea@example.com'
WHERE name = 'chelsea';

SELECT *
FROM users_info;

--데이터 삭제 DELETE
--특정값 삭제, '조건'을 통해서! 
--DDL에선 DROP IF EXISTS

DELETE FROM users_info
WHERE email IS NULL;

SELECT *
FROM users_info;

-- SELECT 구문 
USE world;
SHOW TABLES;

DESC city;

--city 확인하기 (Name, CountryCode, Population)
SELECT Name, CountryCode, Population
FROM city as C
LIMIT 10;

SELECT c.Name AS 이름, c.CountryCode AS 국가코드, c.Population AS 인구수
FROM city as C
WHERE c.Population >= 1000000;

--쿼리문 순서이슈로 인한 에러! 
--FROM-> WHERE -----> SELECT 실행! SELECT의 약어 통하지 X 
--SELECT c.Name AS 이름, c.CountryCode AS 국가코드, c.Population AS 인구수
--FROM city as C
--WHERE 인구수 >= 1000000;(X)


--WHERE 구문 

USE world;

SELECT DISTINCT Countrycode
FROM city;

SELECT *
FROM city
WHERE city.CountryCode ='KOR';

--조건 필터링
--(1) 비교연산
--파이썬 비교연산과 유사하나 일부다름 
--일치연산 같다 (=), 같지 않다 (!=, <>)

SELECT CountryCode AS 국가명, Name AS 도시이름, Population AS 인구수 
FROM city
WHERE Population > 10000000;


--논리연산 >< <> 
WHERE NOT population < 1000000

--범위 연산 BETWEEN 
WHERE Population NOT BETWEEN 1000 and 200000

--포함연산 IN
WHERE CountryCode IN ('KOR','JPN','CHN') 
--OR
WHERE CountryCode ='KOR'
    OR CountryCode ='CHN'

--NULL 여부 IS NULL / IS NOT NULL 
DESC city;
--Null 없음 

DESC country;
--Null 있는 열 체크 

SELECT *
FROM country
WHERE IndepYear IS NOT NULL
    AND Continent = 'Asia'
    AND IndepYear > 1900;

--여러개의 필터링 걸수있다. Null + 비교 + 논리연산 등 


--패턴매칭 LIKE
SELECT *
FROM country AS c
WHERE c.IndepYear IS NOT NULL
    AND c.Name LIKE '%stan';

