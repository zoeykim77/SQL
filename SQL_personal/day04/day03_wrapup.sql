---Day03 복습 : JOIN / 서브쿼리

SHOW DATABASES;--전체 데이터베이스 목록 확인 
USE sakila;
USE world;

SELECT DATABASE(); -- 함수 : 현재 사용중인 데이터베이스 

SHOW TABLES; --현 데이터 내 테이블 목록 확인 

DESC country; --테이블들 중 1개 전체 열속성 확인 / 파이썬 Describe와 유사 

SHOW CREATE TABLE country; --테이블 제작 DDL 확인(더 자세한 확인) / 파이썬 describe 유사 

SELECT *
FROM country
LIMIT 10; ---데이터 대략적인 모습 확인 :  파이선 data.head() 유사 


--- DDL 
--- 프로젝트 진행시 보통 'VIEW' 생성해 진행(자주쓰는 쿼리 저장)
--- 임시테이블 (쿼리문으로 생성)

--- VIEW 생성, 2테이블 조인해 생성 가능 ! / SELECT *하면 code2개 뜸, 열값 정확한 명시 중요!  

CREATE VIEW asia_countries_view AS
SELECT co.Code, co.Name AS country_name, ct.`Name` AS capital_name,
        co.`Population`AS country_ppl
FROM country AS co
JOIN 
    city AS ct
    ON ct.ID = co.`Capital`
WHERE co.`Continent`='Asia';

--- 뷰 확인하기, 추가 확인가능 
SHOW TABLES;

--- 뷰 사용하기, FROM에 뷰이름만 바로 넣기 

SELECT * 
FROM asia_countries_view
WHERE country_population > 100000000;

-- 뷰 수정하기 
CREATE REPLACE VIEW AS 

-- 뷰 삭제하기 

DROP VIEW asia_countries_view;
SHOW TABLES;


--- DML
--- 값(행)에 관한 것(삽입 insert into,조회 update/where,수정,삭제delete from/where) 
--- 우리는 보통 SELECT문 활용 ! : SELECT문 쿼리어는 질의어, 쿼리문! 
--- SELECT는 데이터 가져오오고 조회가능 BUT 데이터 자체 생성하거나 변경하지 않는다.  

---SELECT문만 패자 (insert update delete from 기본만)
---SELECT문 기본구조 
---순서에 맞춰야만 코드가 실행됨 
--- SELECT -> FROM -> JOIN/ON -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT


SELECT "1" + "2"; 
--FROM 절 불요한 경우도 있지만 대부분 쿼리문 "어디에서"라는 테이블 소스가 필요 (FROM 필요!)
--단순 연산시! 


--- 중복값 제거 DISTINCT 
--- 파이썬 UNIQUE 비슷. 

SELECT DISTINCT co.`Continent`
FROM country AS co; -- 대륙유일한목록확인 


--- WHERE절 조건 
--- 비교,논리, 포함, NULL 여부, 패턴 매칭 가능
--- 함수는 불가 (함수는 GROUPBY 후 SELECT에서만 활용!)

--- GROUP BY 
--- 요약, 집계함 
--- 집계함수 반드시 필요!, 묶어준 그룹안 여러행을 하나의 값으로 요약! 



SELECT co.`Continent` AS 대륙별, COUNT(*) AS "국가 수"
FROM country AS co
GROUP BY co.`Continent`;

---AS 국가수 = AS "국가 수" 띄워쓰기 활용원할시!
---BUT, 띄워쓰기는 언더바(_)활용

--- HAVING : 그룹의 필터링 
--- GROUP BY와 꼭 있어야 HAVING 올 수 있다! 세트메뉴! 
--- 필터링시, 집계함수가 불요하다면 HAVING 대신에 WHERE를 먼저 해주는게 낫다.
--- WHERE가 먼저 오니, 데이터를 먼저 솎아주니까! 
--- 집계함수 필요시 HAVING! 

SELECT co.`Continent` AS 대륙별, COUNT(*) AS "국가 수"
FROM country AS co
GROUP BY co.`Continent`
HAVING "국가 수" >=30;

--- ORDER BY : 정렬할 열 + 정렬방식 

SELECT *
FROM country
ORDER BY `Population` DESC
LIMIT 10;


--- 퀴즈 1. 인구가 많은 순서 1위부터 10위까지 대륙별로 몇개가 있는가?
--- 1)메인쿼리 먼저 짜기 "대륙별 나라 몇개?"

SELECT co.`Continent`, Count(*)
FROM country AS co
GROUP BY co.`Continent`;

--- 2)서브쿼리 : 조건, 인구수가 많은순대로 1-10위까지 
--- FROM절에 넣는 INLINE VIEW 
--- 1쿼리 내에서 정리하려고 해도 힘듬! LIMIT, ORDERBY가 이후에 나오기에. 적용 안되어서. 

SELECT co.`Continent`, COUNT(*)
FROM (SELECT *
    FROM country
    ORDER BY `Population` DESC
    LIMIT 10) AS c
GROUP BY c.`Continent`;


--SELECT co.`Continent`, SUM(co.`Population`) AS 총인구수, COUNT(*) 
--FROM country AS co
--GROUP BY co.`Continent`
--HAVING 총인구수 > ( SELECT co.`Continent, SUM(co.`Population`) AS 총인구수FROM country AS coGROUP BY co.`Continent`ORDER BY 총인구수 DESCLIMI 10)
--- 


--- 서브쿼리 : 메인쿼리 안의 또다른 쿼리 
--- SELECT/FROM/WHERE/HAVING 다 올 수 있다. 

--- [1] 행반환에 따라 
--- 단일 행 반환
SELECT CountryCode
FROM countrylanguage
WHERE `Language`='English'


--- 다중행 반환 
--- IN/EXISTS 

SELECT CountryCode
FROM countrylanguage
WHERE `Language`='English' AND `IsOfficial`='T';

--- 다중컬럼 반환
--- 자주쓰이지 않음 
--- WHERE절에서는 두 열의 기준 모두 만족할 경우 필터링시 사용 


--- [2] 연관 방식에 따라 
--- 비연관 서브쿼리 : 서브쿼리 독립적 / 실행속도 빠름 
--- 고정된 결과 집합으로 비교시! 

--- 정부 형태에 'Republic'이 포함된 국가에 속한 모든 도시를 조회하는 경우
SELECT Name, CountryCode
FROM city
WHERE CountryCode IN 
			(SELECT Code 
            FROM country 
            WHERE GovernmentForm LIKE '%Republic%');


--- 연관 서브쿼리 : 메인쿼리랑 연결 
--- 매 행별 반복함 FOR 문처럼, 시간 오래 걸림 
--- 각 행마다 서브쿼리 조건 계속 바뀌어야할때! 

--- 각 국가별 가장 인구가 많은 도시 찾기
SELECT c1.name, c1.population, c1.countrycode
FROM city c1
WHERE population = (
    SELECT MAX(population)
    FROM city c2
    WHERE c1.countrycode = c2.countrycode
);


--- CTE(Common Table Expression) 임시테이블 
--- 파이썬의 lambda 함수처럼 
--- WITH 이름 AS 쿼리문~ 
--- 쿼리내 임시뷰임. 

--- 각 대륙에서 인구가 가장 많은 국가의 정보를 찾아보세요.
--- CTE가 서브쿼리 경우 WHERE절 들어갈텐데, 단계쪼개서 들어감 
--- CTE는 가독성이 떨어질 순 있다 
--- CTE : 문제의 조건 
--- 메인쿼리 : 문제의 값 

-- 1. 대륙별 최대 인구를 계산하는 CTE를 정의합니다.
WITH ContinentMaxPopulation AS (
    SELECT
        Continent,
        MAX(Population) AS max_pop
    FROM
        country
    GROUP BY
        Continent
)
-- 2. 메인 쿼리에서 원본 country 테이블과 CTE를 조인합니다.
SELECT
    c.Continent,
    c.Name,
    c.Population
FROM
    country c
JOIN
    ContinentMaxPopulation cmp 
    ON c.Continent = cmp.Continent -- 대륙이 같고
	AND c.Population = cmp.max_pop -- 해당 국가의 인구가 그 대륙의 최대 인구와 같은 경우
ORDER BY
    c.Continent;