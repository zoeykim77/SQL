-- Active: 1752194083940@@127.0.0.1@3306@world
---SELECT 구문 실행
---작성순서 : SELECT(DISTINCT)->FROM-> JOIN -> WHERE -> GROUPBY-> HAVING -> ORDERBY->LIMIT/OFFSET
---실행순서 : FROM (JOIN) -> WHERE -> GROUPBY -> HAVING -> SELECT(DISTINCT)-> ORDERBY -> LIMIT/OFFSET

USE world;
SELECT DATABASE();

SHOW TABLES;
DESC city;
SELECT *
FROM city AS c
WHERE c.CountryCode ='KOR';


---WHERE : WHERE 절 주의사항 
---SELECT문의 약어 인지 못하고 오류 생김 -> 실행순서의 차이 때문
---FROM문의 약어로 컬럼 다시 지정해 조건 필터링!  

---GROUP BY : 그룹별 집계 
---SELECT에 반드시 GROUPBY 지정한 열과 집계함수가 들어가야 한다. 
---집계함수는 여러개 들어갈 수 있다. 

---HAVING : GROUP BY해 집계한 값들 중 다시 필터링 
---HAVING에서도 약어는 못쓴다.
---그러나, MySQL에서 편의에 따라 약어 사용가능하도록 확장! GROUPBY, HAVING에서! 


---ORDER BY 정렬 마지막! 2번 정렬 가능 (DESC, ASC) 
USE world;
DESC country;
SELECT co.Continent AS 대륙명,
        COUNT(*) AS 나라수
        SUM(co.Population) AS 총인구수 
FROM country AS co
--JOIN 미리 해줌 
--WHERE 약어 안됨 
GROUP BY co.Continent
HAVING 총인구수 > 0 -- 집계함수 가능 / 약어 가능 (My SQL 확장해줌)
ORDER BY 총인구수 DESC 나라수 DESC; 

---LIMIT/OFFSET : 몇개까지/몇번부터~ 
DESC city;
SELECT ct.Name AS 도시명, ct.Population AS 인구수
FROM city AS ct
WHERE ct.CountryCode IN ('KOR', 'JPN','CHN')
ORDER BY ct.Population DESC
LIMIT 10;


--NULL CHK 
SELECT Name, IndepYear 
FROM country 
ORDER BY IndepYear IS NULL DESC, IndepYear DESC;
---NULL 맨위에 

SELECT Name, IndepYear 
FROM country 
ORDER BY IndepYear DESC NULLS LAST;
---NULL 맨아래 ?? 안나옴 

---JOIN : 테이블이 여러개 일때! 
---INNER JOIN : 두테이블의 공통값에 해당하는 데이터만 반환! 
---ON 두테이블 연결할 공통 열, 키, 기준! 

DESC country;
SELECT ct.Name AS 도시명,
        co.Name AS 나라명
FROM city AS ct
INNER JOIN country AS co
ON ct.CountryCode = co.Code;


---LEFT JOIN : 왼쪽 테이블 기준 합치기 
--- 1:1 관계에선 INNER JOIN과 동일하게 반환 

SELECT ct.Name AS 도시명,
        co.Name AS 나라명
FROM country AS co
LEFT JOIN city AS ct
ON co.`Capital`=ct.ID
WHERE co.Name LIKE 'South%';
---LEFT JOIN 이기 때문에, city에 조건에 해당하는 값이 없으면 가져오지 못한다. NULL로 표시 
---LEFT JOIN 권장? 