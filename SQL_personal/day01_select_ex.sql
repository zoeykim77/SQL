--SELECT 이해 

USE world;

SHOW TABLES;

DESC city;

--SELECT문 연습, 순서 필수!--
SELECT Name, Population -- SELECT 컬럼명
FROM city; --FROM 테이블명 

--전체 열 조회
SELECT * 
FROM city;
--SHOW CREATE TABLE ID? auto_increase 확인

--특정 열 조회
SELECT Name, Population
FROM city;

--특정필드 조회, "테이블명.컬럼명" (merge시 헷갈리지 않게) : 현재는 위와 같은 값 반환 
SELECT city.Name, city.Population
FROM city;

--별칭 설정 AS (Alias)
--FROM부터 작업해주며 올라가기 역방향 
--테이블명 축약 
SELECT c.Name, c.Population
FROM city AS c;

--AS 없이도 가능
SELECT c.Name, c.Population
FROM city c;

--컬럼명 축약
SELECT city.CountryCode AS cc
FROM city;

--한글 가능 
SELECT c.Name 국가, c.Population 인구
FROM country AS c;

--[4] 중복제거, unique값 도출 

DESC country;

---country 테이블에서 중복제외 대륙목록 뽑기 

SELECT DISTINCT Continent -- *전체 반환해도 같음 / 각 행 primary key(code)기준 무조건 다르다. 
FROM country;
--> SELECT * FROM country와 같은 값 


