---JOIN : 3개 이상의 테이블 조인 
---JOIN 순차적, 첫번째 + 두번째 조인 이후 세번째 조인 연결 


---1:1 혹은 1:N ? 
---JOIN 연속사용 

USE world;
SELECT DATABASE();

SELECT co.Name AS 국가명,
        ct.Name AS 수도명,
        cl.`Language` AS 공식언어
FROM country AS co
INNER JOIN city AS ct
    ON co.`Capital`=ct.`ID`
INNER JOIN countrylanguage AS cl
    ON cl.`CountryCode`=co.Code
WHERE cl.`IsOfficial` = 'T';



---M:N 다대다관계 중계테이블
---sakila의 배우-영화와의 다대다관계 
USE sakila;
SELECT DATABASE();


---영화와 배우연결! 
---중계테이블인 'film actor' 이용해 연결함 (1,3 테이블을 2를 통해 연결!)

SELECT a.first_name AS 성, a.last_name AS 이름, f.title AS 영화이름
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
INNER JOIN film AS f
    ON f.film_id = fa.film_id;

---ON VS USING 
---ON : 명시적 조건 지정, 두테이블 열이름이 다른경우 사용하면 좋음 
---USING : 조인할 열 이름이 동일할 경우! (열이름 동일한데 2번쓰면 귀찮으니)


---USING 사용하기 
---약어 없이 USING (공통열 이름)
---공백, 들여쓰기, 개행은 편한대로 -> 그러나, 한줄 너무 길게 X
---범용성은 'ON'이 뛰어나다 ( = dhldp >,<, AND, OR 복잡조건 가능)

SELECT a.first_name AS 성, a.last_name AS 이름, f.title AS 영화이름
FROM actor AS a
INNER JOIN film_actor AS fa
    USING (actor_id)
INNER JOIN film AS f
    USING (film_id);