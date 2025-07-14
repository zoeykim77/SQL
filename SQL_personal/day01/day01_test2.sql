--실습 2
--문제 1) 인구가 800만 이상인 도시의 Name, Population을 조회하시오

USE world;
SHOW TABLES;
DESC city;

SELECT c.Name, c.`Population`
FROM city AS c
WHERE c.`Population` >= 8000000; --10개 
-- SELECT에서 Name 컬럼 자동완성 x -> FROM city 지정전이라서
-- FROM 지정후 약어로 c.Name 표현하면 더 좋다!

--문제 2) 한국(KOR)에 있는 도시의 Name, CountryCode를 조회하시오
--데이터확인 
SELECT *
FROM city c
LIMIT 5;
--- 사전에 SELECT * / FROM city / LIMIT 5 -> .head()처럼 전체의 윗행만 확인가능

--정답
SELECT `Name`, `CountryCode`
FROM city c
WHERE c.`CountryCode`= 'KOR'; --70개

--갯수확인 
SELECT COUNT(*)
FROM city c
WHERE c.`CountryCode`= 'KOR'; --70개
--- SELECT COUNT(*) 해서 도시 갯수만 별도로 뽑기 가능 

--문제 3) 이름이 'San'으로 시작하는 도시의 Name을 조회하시오
--정답 
SELECT `Name`
FROM city c
WHERE c.`Name` LIKE 'San%'; -- 110개

-- 중복값제외
SELECT DISTINCT`Name`
FROM city c
WHERE c.`Name` LIKE 'San%';--95개 
-- 중첩값 제외하고 San으로 시작하는 케이스만 조회시 

-- 언더바 차이점 
SELECT DISTINCT`Name`
FROM city c
WHERE c.`Name` LIKE 'San__'; --4개
-- 언더바 __는 San 다음에 두글자 등 글자갯수 제한해 검색도 가능!

--문제 4) 인구가 100만에서 200만 사이인 한국 도시의 Name을 조회하시오

SELECT c.Name
FROM city c
WHERE c.`Population`BETWEEN 1000000 AND 2000000
    AND c.`CountryCode`= 'KOR';---3개 : 대전, 광주, 울산


--문제 5) 인구가 500만 이상인 한국, 일본, 중국의 도시의 Name, CountryCode, Population 을 조회하시오
--IN 연산자!! 그냥 AND = 하면 안나옴 

--조건 1) 나라코드 먼저 찾기
SELECT DISTINCT c.`CountryCode`
FROM city c;
--232개, 너무 많이 나옴 

--조건 2) IN 연산자 
SELECT c.`Name`, c.`CountryCode`, c.`Population`
FROM city c
WHERE c.`Population`>=5000000
    AND c.`CountryCode` IN ('KOR','JPN','CHN'); --6개도시 반환 
--SELECT엔 콤마, 그외는 마지막; 까지 None!

--문제 6) 오세아니아 대륙에서 예상 수명의 데이터가 없는 나라의 Name, LifeExpectancy, Continent를 조회하시오.
---Country 테이블 정보로, 원하는 정보(컬럼) 있는지 확인 : 이름,수명,대륙명 등 
SHOW TABLES;
DESC country;

-- 조건 1) 대륙명 오세아니아 먼저 찾기 (*문제 제대로 읽고 이해하기)
-- DISTINCT 로 열 내 종류 확인 
SELECT DISTINCT c.`Continent`
FROM country as c;


-- 조건 2) 수명 결측 찾기 (오답: 오세아니아 조건 제외됨, 먼저 넣어야했음!!!)
SELECT c.Name, c.LifeExpectancy, c.Continent
FROM country c
WHERE c.`Continent`= 'Oceania'
    AND c.`LifeExpectancy` IS NULL; -- 17개국(X), 8개국 (o)

---질문 1 country 도 c 하면 안되나?
---질문 2 매번 From에 약어 설정? 연결안됨? 
-- SQL은 파이썬과 다른 논리 전개법, 놓치면 이해x 