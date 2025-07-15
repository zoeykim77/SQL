-- VIEW : 복잡한 쿼리 가상테이블 저장 


USE world;
SELECT DATABASE();

--[1] 생성하기 
--아시아(Asia) 대륙에 속한 국가들의 
--이름, 수도, 인구, GNP 정보를 보여주는 asia_countries_view라는 뷰를 생성

SHOW TABLES;
DESC country;
DESC city;
--필요테이블 : country, city
--ON : co.Capital, ct.ID 

SELECT co.Code AS 국가코드, co.Name AS 국가명,
        co.`Population` AS 인구수, co.GNP,
        ct.Name AS 수도명
FROM country AS co
INNER JOIN city AS ct
    ON co.`Capital`=ct.ID
WHERE co.Continent = 'Asia';


--VIEW 생성
--CREATE VIEW 이름 AS 쿼리문 

CREATE VIEW asia_countries_view AS
SELECT co.Code AS 국가코드, co.Name AS 국가명,
        co.`Population` AS 인구수, co.GNP,
        ct.Name AS 수도명
FROM country AS co
INNER JOIN city AS ct
    ON co.`Capital`=ct.ID
WHERE co.Continent = 'Asia';

SHOW TABLES;
--view가 가상의 추가 테이블로 만들어짐 


--[2] 사용하기 : view를 테이블처럼 가져옴 
--자주 사용하는 쿼리문으로 편하게 조회 등 시용가능 

SELECT *
FROM asia_countries_view
LIMIT 10;

SELECT *
FROM asia_countries_view
WHERE 인구수 BETWEEN 100000000 AND 200000000;


--[3] 수정하기 
--CREATE OR REPLACE VIEW 이름 AS 쿼리문 + 추가수정사항 
CREATE OR REPLACE VIEW asia_countries_view AS
SELECT
    co.Code,
    co.Name AS country_name,
    ci.Name AS capital_name,
    co.Population AS country_population,
    co.GNP,
    co.GovernmentForm -- 컬럼 추가
FROM
    country co
JOIN
    city ci ON co.Capital = ci.ID
WHERE
    co.Continent = 'Asia';

DESC asia_countries_view;

SELECT *
FROM asia_countries_view
LIMIT 10;

--[4] 삭제하기 
--DROP VIEW 이름 
--DROP VIEW IF EXISTS asia_countries_view;