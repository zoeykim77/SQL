-- 단일행 함수
-- [1] 문자형 함수

USE world;
--- 1) CONCAT : 문자열들을 이어낸다. 
--- 한국 도시 뽑기
--- 소괄호도 '' 
SELECT CONCAT(ct.Name, '(', ct.`CountryCode`,')')
FROM city AS ct
WHERE ct.`CountryCode`='KOR';


---ASIA로 변경시? 서브쿼리 활용! WHERE절 + IN 
SELECT CONCAT(ct.Name, '(', ct.`CountryCode`,')')
FROM city AS ct
WHERE ct.`CountryCode` IN (
    SELECT country.Code
    FROM country
    WHERE country.`Continent`='ASIA'
);

--- 2) UPPER/LOWER

SELECT CONCAT(ct.Name, '(', ct.`CountryCode`,')')
FROM city AS ct
WHERE ct.`CountryCode` IN (
    SELECT country.Code
    FROM country
    WHERE LOWER(country.`Continent`)='asia'
);

--- 3) SUBSTRING() : 문자열 특정부분, 위치기준 잘라내기
--- 슬라이싱 
--- SUBSTRING(문자열, 시작_위치, 길이) 

SELECT Name, SUBSTRING(Name, 1, 3) AS 'Short Name'
FROM country
LIMIT 5;


--- 4) LENGTH() : 문자열 길이 반환 
--- 5) REPLACE() : 대체 
--- REPLACE (해당문자열, '바꿀부분', '수정한버젼')

SELECT Name, 
	    REPLACE(Name, 'South', 'S.') 
FROM country 
WHERE Name LIKE '%South%';

-- [2] 숫자형 함수
-- 1) 산술연산자 +,-,*,/

USE world;
SELECT co.Name, co.Population / co.SurfaceArea AS '인구 밀도'
FROM country AS co
WHERE co.SurfaceArea > 0;

-- 2) ROUND (), 반올림 
SELECT Name, LifeExpectancy, ROUND(LifeExpectancy,3) AS 'Rounded LifeExpectancy'
FROM country
LIMIT 5;

-- 3) CEIL() / FLOOR(), 올림 OR 내림 가장 가까운 정수 (.5반 넘지 않아도)

SELECT CEIL(3.14), FLOOR(3.9999);

--  4) TRUNCATE(), 지정된 자릿수에서 버리기 (반올림X)

SELECT TRUNCATE(3.2499039203902,3);--3.249 (반올림 없이 소수점 3번째에서 버림)
SELECT ROUND(3.2499039203902,3);--3.250 (반올림)


--- [3] 날짜형 함수
--- SELECT DATE_FORMAT() 형변환
--- SELECT 함수 NOW(), CURDATE(), CURTIME()
--- SELECT DATE_ADD/SUB(date, interval) 연산 
--- DATEDIFF(일자, CURDATE()) 비교 

SELECT NOW(), CURDATE(), CURTIME();

SELECT YEAR(NOW()) AS '연', MONTH(NOW()) AS '월', DAY(NOW()) AS '일';
SELECT WEEKDAY(NOW());

SELECT DATE_FORMAT(NOW(),'%a');
SELECT DATE_FORMAT(NOW(), '%Y년 %m월 %d일');


--- 날짜 계산하기 
--- DATE_ADD/SUB(date, interval) 연산 

-- 오늘로부터 10일 뒤
SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY);
-- 지금으로부터 3시간 전
SELECT DATE_SUB(NOW(), INTERVAL 3 HOUR);


--- DATEDIFF() 두 날짜 빼기 (-) 연산! 
USE sakila;

SELECT AVG(DATEDIFF(r.return_date,r.rental_date)) 
FROM rental AS r; -- 전체고객 평균대여일 5일 반환


---크리스마스까지 남은 날짜

SELECT DATEDIFF('2025-12-25', CURDATE());


---[4] 결측 NULL 관련 함수
---1) COALESCE : 인자중 NUll 아닌 첫번째 값 반환 
---COALESCE(GNPOld, GNP,0), GNPOld가 결측이면 GNP로 대체 / 둘다 결측이면 0 
USE world;

SELECT Name,  GNPOld, GNP, COALESCE(GNPOld, GNP,0)
FROM country;

DESC country; --- NULL 가능 

SELECT COUNT(*)
FROM country
WHERE GNP IS NULL; -- 결측 0으로 뜸


SHOW CREATE TABLE country;


--- 2) IFNULL
---IFNULL(검사할 값, NULL경우 대체값)

SELECT Name, HeadOfState, Continent, IFNULL(HeadOfState, '정보 없음') AS '국가원수'
FROM country
WHERE Continent = 'Europe'
LIMIT 10;
--- 이경우, NULL 이 아닌 공백으로 되어 있어 적용x 


--- 3) NULLIF 
--- A,B 같으면 NULL / 다르면 A 반환 
--- 일부러 결측치 발생시키는 형태 

--- 퍼센티지가 0.2일 경우 결측으로 받아들여 분석에서 제외시킴 
SELECT Language, Percentage, NULLIF(Percentage, 0.2)
FROM countrylanguage
WHERE CountryCode = 'USA';


--- 다중행함수
--- [1] 전체 테이블 


SELECT COUNT(*), AVG(rental_rate), MIN(rental_rate)
FROM film;
--- 전체의 size파악 COUNT

--- [2] GROUPBY 집계함수

USE world;

SELECT Continent, SUM(Population)
FROM country
GROUP BY Continent;