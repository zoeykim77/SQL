-- Active: 1752194083940@@127.0.0.1@3306@world
---JOIN 또다른 형태
---CROSS JOIN : 조인 조건(ON,USING) 없이 두 테이블의 모든 행 짝지어, 가능한 모든 조합! 
---ON 기준 불요 : ON 없이 사용시 자동 CROSS JOIN 해버림 
---사용하는 경우 : 모든 경우의 수 생성시! 

USE world;
SELECT
    A.Continent,
    B.Language
FROM
    -- 첫 번째 테이블: 3개의 고유한 대륙 목록
    (SELECT DISTINCT Continent 
    FROM country 
    WHERE Continent IN ('Asia', 'Europe', 'Africa')) AS A
CROSS JOIN
    -- 두 번째 테이블: 2개의 고유한 언어 목록
    (SELECT DISTINCT Language 
    FROM countrylanguage 
    WHERE Language IN ('Arabic', 'French')) AS B;

---SELF JOIN : 자기자신에게 조인! 
---사용하는 경우 : 동일 테이블 내 행끼리 비교할때 ex) 같은 대륙에서 한국제외 다른 모든 국가 

SELECT
    c2.Name AS Other_Country_On_Continent,
    c1.Continent
FROM
    country AS c1 -- 테이블의 첫 번째 별칭
INNER JOIN
    country AS c2 ON c1.Continent = c2.Continent -- 동일한 테이블의 두 번째 별칭
WHERE
    c1.Name = 'South Korea' AND c2.Name <> 'South Korea';