---  함수

--- 1. 분류 
--- [1] 단일행 함수 : 각 행에 개별적 작동, 행 하나당 결과 하나.
--- 자료형에 따라 사용할 수 있는 함수가 조금씩 다름 
--- UPPER, ROUND, NOW()

--- [2] 다중행 : 여러행 그룹묶어, 그룹전체에 대한 단 하나의 대표값
--- 데이터 그룹 전체 요약! 
--- 집계함수!!! COUNT, SUM, AVG(column)

--- 2. 사용법 
--- SELECT 절 : 조회할 데이터 가공해서 보여줄때 / 원본 데이터 변형없이 '보여주는 형식만' 변경

SELECT UPPER(Name), LOWER(Name), LENGTH(Name)
FROM country;

--- WHERE 절 : 특정 조건으로 필터링시 사용
--- 이름이 America, 캐피탈 형태가 찾기 힘드니 형변환함수로 쉽게 필터링! 

SELECT Name
FROM country
WHERE LOWER(Continent) = 'asia';


--- GROUP BY / HAVING 절 
--- GROUP BY엔 목적이 있다. 즉, 집계함수 넣어줘야함 

USE sakila;
SELECT DATABASE();

DESC rental;
SELECT YEAR(r.rental_date) AS rental_year , COUNT(*) AS cnt
FROM rental AS r
GROUP BY YEAR(r.rental_date)
HAVING COUNT(*) >200;
--- 렌탈일자에서 연도만 뽑아, 연도별 렌탈수 추출 가능 
--- HAVING 가능 
--- 약어 설정시 함수 해치지 않게 설정 필요! 

SELECT MONTH(r.rental_date) AS rental_month , COUNT(*) AS cnt
FROM rental AS r
WHERE year(r.rental_date) = 2005
GROUP BY rental_month;

--- ORDER BY 절 
--- 도시 이름순으로~ 
USE world;
SELECT ct.`Name`
FROM city AS ct
ORDER BY LENGTH(ct.`Name`) DESC;