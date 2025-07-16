-- Active: 1752194083940@@127.0.0.1@3306@world
--- 실습 11 

USE world;

-- 문제 1) 누락된 정보 확인하기
DESC country;

SELECT c.`Continent`, c.`Name`, c.`LifeExpectancy`, c.GNP
FROM country AS c
WHERE c.LifeExpectancy IS NULL
    OR c.GNP IS NULL;


-- 문제 2) 결측치를 대륙별 평균으로 대체하기 (**)
--기대 수명(LifeExpectancy)이 NULL인 국가들을, 
--각 국가가 속한 대륙(Continent)의 평균 기대 수명으로 대체하여 조회하세요. 
--원본 값과 대체된 값을 함께 보여주세요.


---정답해설
---대륙별 평균 기대수명 -> 대체 
---메인 쿼리 : 찾고자 하는 값 넣기. CALSECE 기본 공식 사용! BUT 함수, 서브쿼리 바로 넣지 못함
---JOIN 필요 

SELECT c1.`Name`, c1.`LifeExpectancy`, COALESCE(c1.`LifeExpectancy`, c2.평균기대수명)
FROM country AS c1
JOIN (SELECT`Continent`, AVG(`LifeExpectancy`) AS 평균기대수명
    FROM country
    GROUP BY `Continent`) AS c2
ON c1.`Continent`=c2.`Continent`;


--- 서브쿼리로 대륙별 평균수명 구하기 : GROUP BY, AVG 함수 
--- 대륙별에서도 NULL 값 존재 (대륙별 NULL값 제외원할시 별도 CTE 필요)
SELECT c.`Continent`, AVG(c.`LifeExpectancy`)
FROM country AS c 
GROUP BY c.`Continent`;

SELECT c.country, REPLACE(c.`LifeExpectancy`,NULL,AVG(c.`LifeExpectancy`))
FROM country AS c
GROUP BY c.country;

-- 문제 3) 카테고리 표준화하기

DESC country;


SELECT REPLACE(c.GovernmentForm,'%Republic%', 'Republic'), 
        SUBSTRING_INDEX(c.GovernmentForm, ' ' 'Republic',2)
FROM country AS c;

-- 문제 4) '인구 밀도' 계산하기

DESC country;


SELECT ROUND(c.Population / c.`SurfaceArea`,0) AS 인구밀도
FROM country AS c
WHERE c.`SurfaceArea` > 0
    AND c.`Population` > 0;


-- 문제 5) '1인당 GNP' 계산하기

SELECT c.`Continent` AS 대륙명, c.`Name`AS 국가명, 
        c.GNP / c.`Population` * 1000000 AS 1인당GNP
FROM country AS c
WHERE c.`Population` > 0;


-- 문제 6) '수도 인구 비율' 계산하기
DESC country;
DESC city;

SELECT *
FROM city
WHEN Name ='Seoul';

SELECT ct.`Population`/c.`Population`
FROM country AS c
JOIN city AS ct
ON c.`Population`=ct.`Population`
WHERE c.`Name` IN (
        SELECT c.`Name`
        FROM country AS c
        WHEN c.`Capital`='T'
);