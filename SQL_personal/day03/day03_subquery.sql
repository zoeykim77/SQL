---서브쿼리 (Subquery)
---쿼리 안에 쿼리! 

USE world;
SELECT DATABASE();
SHOW TABLES;

---SELECT 절에서 서브쿼리 사용 
---스칼라 서브쿼리 = 조인과 같은결과 
---서브쿼리로 다른 테이블 정보 가져옴(조인시처럼 기존 테이블 자료도 사용가능)

--서브쿼리 
SELECT c.Name AS 나라명,
        (SELECT Name
         FROM city AS ct
         WHERE ct.ID = c.`Capital`--조인의 'ON'
         ) AS 수도명
FROM country AS c;


--조인시
SELECT co.`Name` AS 나라명, ct.Name AS 수도명
FROM country AS co
JOIN city AS ct
ON ct.ID = co.`Capital`


---FROM 절에서도 서브쿼리 가능
---인라인 뷰 
---아예 추출할 테이블에서 조건 정리 
---조건문 선정리 

SELECT *
FROM (
    SELECT `Name`,Population
    FROM city AS ct
    WHERE ct.`Population` > 500000) AS Bigcities;


---WHERE 절에서도 서브쿼리 가능
---필터링 조건 
---두 테이블 JOIN 없이도 필터링 해 확인가능 

SELECT *
FROM city
WHERE `CountryCode`IN
    (
        SELECT `Code`
        FROM country
        WHERE `Continent`= 'EUROPE'
    )
ORDER BY `Population`DESC;


SELECT `Code`
FROM country
WHERE `Continent`='ASIA';
---해당 목록에 CountryCode가 있는지 확인 (T/F)
---True에 해당하는 케이스만 조회 (필터링 조건)


---HAVING 절 서브쿼리 
---그룹필터링, 함수에도 적용 
---약어? 

SELECT co.`Continent` AS 대륙명, SUM(co.`Population`) AS 총인구수
FROM country AS co
GROUP BY co.`Continent`
HAVING 총인구수 >
        (
        SELECT co.`Population`
        FROM country AS co
        WHERE co.`Name` = 'India'
        );


SELECT co.`Population`
FROM country AS co
WHERE co.Name='Japan';
---서브쿼리에 넣어주면 각기 다른 결과 확인 가능 


---그외 
--- **`INSERT`, `UPDATE`, `DELETE`, `CREATE` 문**
--- 데이터 조작(DML) 및 정의(DDL) 시에 대상을 지정하거나 값을 설정하는 데 사용

-- INSERT 예시 : 행,열 값 넣어줄때도 쿼리문 사용 
INSERT INTO big_countries (Code, Name)
SELECT Code, Name 
FROM country 
WHERE Population > 100000000;