-- Active: 1752194083940@@127.0.0.1@3306@sakila
-- 실습 6 JOIN 3개 테이블 

USE sakila;
SELECT DATABASE();
SHOW TABLES;

-- 문제 (1) 고객 정보, 주소, 도시 조회 
--address 테이블은 city_id를 가지고 있지만, 실제 도시 이름은 city 테이블에 있습니다. 
--customer, address, city 세 개의 테이블을 연결하여 
--고객의 기본 정보, 주소, 그리고 도시 이름까지 한 번에 확인하는 쿼리를 작성해 보세요.

--사용테이블 : customer, address, city 
--ON : address_id, city_id


---내답 : RIGHT JOIN / USING 활용 
DESC customer;
DESC address;
DESC city;


SELECT c.first_name AS 성, c.last_name AS 이름,c.email AS 이메일주소,
        ad.address AS 주소, ad.postal_code AS 우편번호,
        ct.city AS 도시명
FROM customer AS c
RIGHT JOIN address AS ad
    USING (address_id)
RIGHT JOIN city AS ct
    USING (city_id);

--- 해설 : LEFT JOIN / ON으로 적용! 

SELECT c.first_name AS 성, c.last_name AS 이름,
        ad.address AS 주소, ad.postal_code AS 우편번호,
        ct.city AS 도시명
FROM customer AS c
LEFT JOIN address AS ad
    ON c.address_id = ad.address_id 
LEFT JOIN city AS ct
    ON ct.city_id = ad.city_id;


-- 문제 (2) London(city)에 사는 고객의 기본 정보, 주소, 도시 조회
--customer, address, city 테이블을 JOIN하여 
--'London'에 거주하는 고객들만 찾아내어, 
--그들의 기본 정보, 주소, 도시를 조회하는 쿼리를 작성해 보세요.

DESC customer;
DESC address;
DESC city;

SELECT c.first_name AS 성, c.last_name AS 이름,
        ad.address AS 주소, ad.postal_code AS 우편번호,
        ct.city AS 도시명
FROM customer AS c
LEFT JOIN address AS ad
    USING (address_id)
LEFT JOIN city AS ct
    USING (city_id)
WHERE ct.city = 'London';
---RIGHT JOIN 했을때, 고객 NULL 값 도시명만 있는 값 출력됨. 고객이름 없나? 
---LEFT JOIN시, NULL 제외 반환


-- 문제 (3) 도시별 고객 수 조회
-- customer, address, city 테이블을 JOIN하여 
--각 도시에 몇 명의 고객이 살고 있는지 계산해 보세요.
--고객 수가 많은 순서대로 정렬(ORDER BY)하여 결과를 확인해 보세요.

---GROUPING + 집계 
DESC customer;
DESC address;
DESC city;


SELECT ct.city AS 도시명, SUM(c.customer_id)
FROM customer AS c
LEFT JOIN address AS ad
    USING (address_id)
LEFT JOIN city AS ct
    USING (city_id)
GROUP BY ct.city
ORDER BY SUM(c.customer_id) DESC;

---정답 : COUNT(*) 고객수 

SELECT ct.city AS 도시명, COUNT(*) AS 고객수
FROM customer AS c
LEFT JOIN address AS ad
    USING (address_id)
LEFT JOIN city AS ct
    USING (city_id)
GROUP BY ct.city
ORDER BY 고객수 DESC;

-- 문제 (4) 고객의 기본 정보, 주소, 국가 조회
-- city 테이블은 country_id를 가지고 있고, 국가 이름은 country 테이블에 있습니다. 
--총 네 개의 테이블(customer, address, city, country)을 JOIN하여 
--고객의 전체 주소 정보(주소, 도시, 국가)를 조회해 보세요.

--조인 테이블 : 4개 customer, address, city, country
DESC customer;
DESC address;
DESC city;
DESC country;


SELECT  c.first_name AS 성, c.last_name AS 이름, c.email AS 메일주소,
        ad.address AS 주소,
        ct.city AS 도시명,
        co.country AS 국가명
FROM customer AS c
LEFT JOIN address AS ad
    USING (address_id)
LEFT JOIN city AS ct
    USING (city_id)
LEFT JOIN country AS co
    USING (country_id);


-- 문제 (5) 배우가 출연한 영화 조회
-- 배우 정보는 `actor` 테이블에, 영화 정보는 `film` 테이블에 있습니다. 
-- 배우와 영화의 관계는 `film_actor`라는 중간 테이블을 통해 연결됩니다.

세 테이블을 JOIN하여 각 배우의 이름과 그 배우가 출연한 영화의 제목 목록을 조회해 보세요.
DESC actor;
DESC film;
DESC film_actor;

SELECT  a.first_name, a.last_name,
        f.title AS 영화제목
FROM actor AS a
LEFT JOIN film_actor AS fa
    USING (actor_id)
LEFT JOIN film AS f
    USING (film_id);

-- 문제 (6) 특정 배우가 출연한 영화의 제목을 조회
-- 이 중, first_name이 PENELOPE 인 배우가 출연한 영화를 구하세요.

DESC actor;
DESC film;
DESC film_actor;

SELECT  a.first_name, a.last_name,
        f.title AS 영화제목
FROM actor AS a
LEFT JOIN film_actor AS fa
    USING (actor_id)
LEFT JOIN film AS f
    USING (film_id)
WHERE a.first_name = 'PENELOPE';