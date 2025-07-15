--- 실습 7 서브쿼리 

USE sakila; -- 데이터베이스 선택
SELECT DATABASE(); -- 데이터베이스 확인
SHOW TABLES; -- 테이블 목록 확인

--- 문제 (1) 평균보다 비싼 대여료의 영화 찾기
--- 전체 영화의 평균 대여료(rental_rate)보다 비싼 대여료를 가진 영화의 
--  제목(title)과 대여료를 조회하세요.


--- 정답해설 
--- 조건 : 평균보다 비싼 대여료 (단일행 반환 서브쿼리)
--- 대상 테이블 : film 
--- TIP : WHERE 절에서 AVG 함수 적용 안되기에, WHERE 절 서브쿼리 

SELECT f.title, f.rental_rate
FROM film AS f
WHERE f. rental_rate > (
    SELECT AVG(f.rental_rate)
    FROM film AS f
);

----내답 
DESC payment; --payment/customer id, rental id
DESC film; ---film Id/title
DESC rental; ---rental id

DESC film_list;---price, title, 

SELECT f.title, p.payment
FROM film AS f
WHERE 

SELECT 
FROM payment AS p
WHERE AVG(p.amount)

SELECT f.title, p.amount
FROM film AS f
WHERE f.film_id IN (
    SELECT p.amount
    FROM payment AS p
    WHERE p.amount >= AVG(p.amount)
);

--- 문제 (2) 특정 고객의 결제 내역과 전체 평균 결제액 함께 보기
--- 사용테이블 : customer, payment
--- 고객 ID(customer_id)가 5인 고객의 
--- 모든 결제 ID(payment_id), 결제액(amount)과 함께, 
--- 전체 고객의 평균 결제액을 모든 행에 함께 표시하여 조회하세요.
DESC customer; --customer id 
DESC payment; --amount 

SELECT c.customer_id, AVG(p.payment)
FROM 
    (SELECT c.customer_id, p.payment
    FROM payment p
    WHERE c.customer_id=5)


SELECT c.customer_id, p.payment_id, p.amount
FROM payment p
WHERE c.customer_id = 5
GROUP BY c.customer_id
HAVING 
    (SELECT
     FROM
     WHERE ) 

SELECT c.customer_id, p.payment_id, p.amount, AVG(p.amount)
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY customer_id
HAVING c.customer_id = 5;

--- 문제 (3) 'Action' 카테고리에 속한 영화의 재고 목록 조회
---'Action' 카테고리에 속한 영화들의 ID 목록을 서브쿼리로 조회한 뒤, 
--- 이 영화 ID에 해당하는 재고만 inventory 테이블에서 모두 조회하세요.


--- 정답 해설 
--- 대상 테이블 : inventory
--- 조건 : Action 카테고리 속하는 영화 ID만 고른다. 
--- 다중행 서브쿼리 
--- 서브쿼리 내 JOIN함! 
--- WHERE 시작과 = 서브쿼리 SELECT 시작 같은 변수여야 한다? 

SELECT *
FROM inventory AS inv
WHERE inv.film_id IN (
    SELECT fc.film_id
    FROM film_category AS fc
    JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
);

DESC film_category; -- film id, category id
DESC inventory; --film id, inventory id
DESC category; -- category_id, name 
SELECT *
FROM category;

SELECT f.film_id,
    (
    SELECT c.name
    FROM category AS c
    WHERE c.name = 'Action'
    )
FROM film_category AS fc
WHERE catego


--- 문제 (5) 고객별 총 결제액과 평균 결제액을 동시에 조회
--- `payment` 테이블을 이용해 고객별(**`customer_id`**)로 
---**총 결제액**과 **평균 결제액**을 계산하는 서브쿼리를 작성하세요. 

---그리고 이 서브쿼리(파생 테이블)를 `customer` 테이블과 `JOIN`하여 
---고객의 **이름**과 함께 위에서 구한 **총 결제액**, **평균 결제액**을 조회하세요.


--- 서브쿼리 먼저 만들기 & 약어 붙이기 
    (
    SELECT p.customer_id, SUM(p.amount) AS 총결제액, AVG(p.amount) AS 평균결제액
    FROM payment AS p
    GROUP BY p.customer_id ) AS p_summary 


--메인 쿼리문과 합치기 
SELECT c.first_name, c.last_name, p_summary.총결제액, p_summary.평균결제액
FROM customer AS c
JOIN 
    (SELECT p.customer_id, SUM(p.amount) AS 총결제액, AVG(p.amount) AS 평균결제액
    FROM payment AS p
    GROUP BY p.customer_id ) AS p_summary 
    ON p_summary.customer_id = c.customer_id;



