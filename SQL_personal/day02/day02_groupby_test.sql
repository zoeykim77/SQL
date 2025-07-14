-- Active: 1752194083940@@127.0.0.1@3306@world
--실습 2

USE world;

SHOW TABLES;

DESC country;

-- 문제 (1) 대륙별 총 인구수를 구하시오
SELECT c.Continent AS 대륙, SUM(Population) AS 총인구수
FROM country AS c
GROUP BY c.Continent;


--문제 (2) Region별로 GNP가 가장 높은 나라를 찾으시오
--'나라이름' 만 따로 SELECT? 
DESC country;

SELECT c.Region AS 지역, MAX(GNP)
FROM country AS c
GROUP BY c.Region
HAVING c.Region Name;

SELECT c.Region, MAX(GNP)
FROM country AS c
GROUP BY c.Region
HAVING COUNT(c.Name)>0;


--해설 
SELECT c.Region AS 지역명, MAX(c.`GNP`) AS 최대GNP
FROM country AS c 
GROUP BY c.Region
ORDER BY c.Region DESC;


--문제 (3) 대륙별 평균 GNP와 평균 인구를 구하시오
SELECT c.Continent AS 대륙, 
    AVG(GNP) AS 평균GNP, 
    AVG(Population) AS 평균인구수
FROM country AS c
GROUP BY c.Continent;

--문제 (4) 인구가 50만에서 100만 사이인 도시들에 대해, District별 도시 수를 구하시오
DESC city;
SELECT c.District, COUNT(*)
FROM city AS c
WHERE c.Population BETWEEN 500000 AND 1000000
GROUP BY c.District;


--문제 (5) 아시아 대륙 국가들의 Region별 총 GNP를 구하세요
DESC country;
SELECT c.Region AS 지역, SUM(c.GNP)
FROM country AS c
WHERE c.Continent = 'ASIA'
GROUP BY c.Region;