--- 데이터 반환 형태에 따른 서브쿼리 
--- [1] 단일행 서브쿼리 
--- 단일행 -> 단일값 조회 
--- 서브쿼리가 단일한 값을 "반환"
--- 하나의 값을 반환하여, > / = / < 과 같은 비교연산 한다! 

--- 평균 인구수보다 인구가 많은 도시들 조회
--- 평균인구수보다 인구가 많다 (필터링 조건)
--- 필터링 걸기 위해 알아야 하는 '평균인구수'-> 서브쿼리


SELECT *
FROM city AS ct
WHERE ct.`Population` > 
    (
    SELECT AVG(ct.`Population`)
    FROM city AS ct
    );
---WHERE 절에 바로 AVG 함수 적용 안되므로, 서브쿼리 활용 


---가장 많은 인구를 가진 도시의 국가정보
---조건 : 가장 많은 인구의 도시
---사용되는 테이블 : city, country
SELECT *
FROM country AS co
WHERE co.`Code` = (
    SELECT ct.`CountryCode`
    FROM city AS ct
    ORDER BY ct.`Population` DESC
    LIMIT 1
);


SELECT *
FROM city AS ct
ORDER BY ct.`Population` DESC
LIMIT 1;




---[2] 다중행 서브쿼리 
---서브쿼리가 반환하는 값이 여러개
---IN, ANY, ALL, EXIST 연산자 
---여러 값을 한번에 비교하기 어려워서!

---예시 1) 공식언어 English인 다양한 국가 이름 조회 
---사용테이블 : country
---조건으로 필터링 : 언어정보(Countrylanguage)
---굳이 조인해서 찾고 싶지 않다면! 


SELECT co.Name 
FROM country AS co
WHERE co.`Code` IN (
    SELECT cl.`CountryCode`
    FROM countrylanguage AS cl
    WHERE cl.`Language` = 'English'
        AND cl.`IsOfficial`='T'
);

---서브쿼리를 별도로 빼두고 다양하게 활용하기도 한다.

 (
    SELECT cl.`CountryCode`
    FROM countrylanguage AS cl
    WHERE cl.`Language` = 'English'
        AND cl.`IsOfficial`='T'
)


---예시 2) 인구 500만 이상인 도시가 있는 국가 찾기
---사용 테이블 : country
---조건 : 인구 500만 이상의 도시 city 

SELECT co.`Code`, co.`Name`
FROM country AS co
WHERE co.`Code` IN (
    SELECT ct.countryCode
    FROM city AS ct
    WHERE ct.`Population` >= 5000000
);



--- [3] 서브쿼리 안에 서브쿼리 < JOIN (3개이상, 중개테이블) 이 나을 수 있다
---지나친 중첩은 가독성 떨어뜨린다. 
---예시 3) Action 카테고리에 속한 영화들 찾기

--- [4] 다중 컬럼 서브쿼리 
---  메인쿼리에서 여러개의 '컬럼'을 동시 비교할 때!  
--- 예시 4) 각 나라에서 가장 인구가 많은 도시, 인구수 정보 조회 
--- 역시 복잡하니 JOIN이 나을 수도! 

SELECT ct.`Name`, ct.`CountryCode`, ct.`Population`
FROM city AS ct
WHERE (ct.`CountryCode`, ct.`Population`) IN (
        SELECT ct.`CountryCode`, MAX(ct.`Population`)
        FROM city AS ct
        GROUP BY ct.`CountryCode`);

--- 서브쿼리 먼저 작성, city에서 국가코드와 인구수만 등장 
SELECT ct.`CountryCode`, MAX(ct.`Population`)
FROM city AS ct
GROUP BY ct.`CountryCode`;

