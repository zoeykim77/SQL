--WHERE 조건으로 필터링 하기 

USE world;

SHOW TABLES;
DROP TABLE IF EXISTS test;
SHOW TABLES;

DESC city;


-- [1] 비교연산자 
SELECT *
FROM city AS c
WHERE c.`Population`>100000; 
-->3558개 필터링 vs 필터링 전 4097개
-->파이썬 연산자 같은 부분 : '비교연산'  >, >=, <, <=, 
-->파이썬 연산자 다른 부분 : '일치여부'  = 수학과 동일하게! (파이썬 ==) != 혹은 <> 

-- [2] 논리연산자
--AND, OR, NOT 

DESC country;

SELECT COUNT(*) --count 함수 갯수 반환 
FROM country AS c
WHERE c.`Population`>1000000 OR c.`Continent`='Asia'; -- 논리연산자 

SELECT * 
FROM country AS c
WHERE c.`Population`>1000000 
    AND c.`Continent`='Asia'
    AND c.`IndepYear`>1990;

-- [3] 범위연산자 
-- BETWEEN : 범위 필터링, NOT BETWEEN : 범위 빼고 필터링 

SELECT *
FROM country c
WHERE c.`Population`BETWEEN 100000 AND 200000;

-- [4] 포함연산자 = 멤버십 연산자 IN, NOT IN ()
-- IN : 목록 속한 모든 케이스에 대해서만 필터링해 조회  

SELECT *
FROM country c
WHERE Code NOT IN ('KOR', 'JPN','CHN');

-- [5] 결측치 확인(NULL CHK)
DESC country; --Null이 가능한 열인지 체크(제약이 Not Null 이 아닌!)
SELECT *
FROM country c
WHERE c.`LifeExpectancy` IS NULL
    AND c.`IndepYear`IS NOT NULL;
--이후 대체값 UPDATE 가능 

-- [6] 패턴매칭
--LIKE

SELECT * 
FROM country c
WHERE Name NOT LIKE '%on%';
-- '%str' 'str%' 등 
-- country 매번 축약어 지정해야? 위에서 하면 연속안됨?
