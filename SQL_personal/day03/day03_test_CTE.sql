--- 실습 9 서브쿼리로 작성된 예시를 보고 직접 CTE 쿼리로 변환해 보세요.

--- 문제 (1) 특정 카테고리 영화를 빌린 적 없는 고객 찾기
--- 'Action' 카테고리의 영화를 한 번도 빌린 적 없는 고객의 이름과 성을 조회하세요.
--- 사용할 테이블 : 카테고리, 렌탈, 고객 정보, 카테고리 필름, 인벤토리 (연결되는 키값들 찾기)
DESC customer; --name 
DESC category; --category id, name 
DESC rental; --rental id, invent ID, customer ID 
DESC inventory; --film ID, inven ID 
DESC film_category; --film ID , category ID 
--- CTE 짜기 
--- 단계1. Action 영화 대여자 -> CTE (서브쿼리의 JOIN을 여기서!)
--- 단계2. 영화 대여하지 않은 고객 찾기 ->  메인쿼리 (찾고자하는 결과값 + WHERE 절 섭쿼리로 CTE)
WITH Actionppl AS (
    SELECT DISTINCT r.customer_id
    FROM rental AS r
    JOIN inventory AS inv
    ON inv.inventory_id = r.inventory_id
    JOIN film_category AS fc
    ON fc.film_id = inv.film_id
    JOIN category AS cat
    ON fc.category_id = cat.category_id
    WHERE cat.name ='ACTION'
)
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE c.customer_id NOT IN(
    SELECT customer_id
    FROM `Actionppl`
);


-- 더 간단한 방법: LEFT JOIN 사용
SELECT c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r 
ON c.customer_id = r.customer_id
LEFT JOIN inventory i 
ON r.inventory_id = i.inventory_id
LEFT JOIN film_category fc 
ON i.film_id = fc.film_id
LEFT JOIN category cat 
ON fc.category_id = cat.category_id 
AND cat.name = 'Action'
WHERE cat.category_id IS NULL
GROUP BY c.customer_id, c.first_name, c.last_name;

---서브쿼리문 
SELECT c.first_name, c.last_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE r.customer_id = c.customer_id
    AND cat.name = 'Action'
);



--- 문제 (2) 우수 고객이 대여한 영화 목록 조회
--- 영화 대여 횟수가 40회 이상인 
--- 우수 고객들이 대여한 모든 영화의 '제목'을 중복 없이 조회하세요.
--- 사용 테이블 : 4개 
--- 찾는 값 : 우수고객 대여 영화 제목
--- 조건 : 중복없이, 우수고객(40회이상 렌탈)

DESC rental; --customer_id, rental id, inven id/ 40회이상 대여
DESC customer; -- customer_id / 고객정보 
DESC film; --film id, title / 제목 but 렌탈과 이어주는 중개테이블 필요 
DESC inventory; -- film id, inven id / 필름-렌탈 이어주는 중계!

SHOW TABLES;

--- 서브쿼리문 : 영어구문 같음. 두괄식, 조건은 맨 안에.
SELECT DISTINCT f.title
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM rental r
    JOIN inventory i 
    ON r.inventory_id = i.inventory_id
    WHERE r.customer_id IN (
        SELECT customer_id
        FROM rental
        GROUP BY customer_id
        HAVING COUNT(*) >= 40
    )
);

-- CTE로 찾기 
-- 단계 1. VIP 고객 먼저 찾기 렌탈 40회 이상 -> CTE 
-- 단계 2. 해당 고객의 대여한 모든 영화 제목 찾기 -> 메인 쿼리 + JOIN 중첩 + Where 조건(CTE 우수고객 연결) 

WITH VIP AS (
    SELECT customer_id
    FROM rental AS r
    GROUP BY customer_id
    HAVING COUNT(rental_id) >= 40
)

SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id=r.inventory_id
WHERE r.customer_id IN (
    SELECT customer_id
    FROM VIP
);


-- 가장 간단한 방법: JOIN 사용 / 우수고객을 별도 테이블, 섭쿼리로 넣는 것 동일 JOIN쪽! 
SELECT DISTINCT f.title
FROM film f
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id
JOIN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) >= 40
) vip 
ON r.customer_id = vip.customer_id;