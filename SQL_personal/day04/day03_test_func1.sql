-- Active: 1752194083940@@127.0.0.1@3306@sakila
--- 실습 10) 1-3

USE sakila;

--- 문제 1) 고객 전체 이름 만들기 

DESC customer;

SELECT CONCAT(c.last_name,' ',c.first_name) AS full_name
FROM customer AS c;


--- 문제 2) 영화 제목 대문자, 설명 소문자 

DESC film;

SELECT UPPER(f.title), LOWER(f.DESCRIPTION)
FROM film AS f;


--- 문제 3) 고객 이메일에서 아이디만 추출하기
--- 데이터 먼저 확인 
SELECT *
FROM customer AS c
LIMIT 10;

---SUBSTRING_INDEX 함수 활용(공식문서) 
---구분자부터 INDEX 
--- @ 전후로 앞 1 
SELECT c.email, SUBSTRING_INDEX(c.email, '@', 1) AS user_id
FROM customer AS c;

--- 문제 4) 결제 금액 반올림/올림/버림 비교

USE sakila;
DESC payment;

SELECT ROUND(p.amount,0) AS 반올림, 
        CEIL(p.amount) AS 정수올림, 
        TRUNCATE(p.amount,0) AS 정수버림
FROM payment AS p;


-- 정답, FLOOR! 두개 넣을 필요 없음
SELECT p.amount,
        ROUND(p.amount) AS 반올림, 
        CEIL(p.amount) AS 정수올림, 
        FLOOR(p.amount) AS 정수버림
FROM payment AS p;


--- 문제 5) 대여 날짜를 특정 형식으로 출력 

USE sakila;

SELECT DATE_FORMAT(r.rental_date,'%Y-%m-%d(%a)')
FROM rental AS r;


--- 문제 6) 대여 요일 별 렌탈건수와 총수익
DESC rental;--rental id, rental date 
DESC payment;--rental id, amount

SELECT DATE_FORMAT(r.rental_date, '%a'), COUNT(r.rental_id), SUM(p.amount)
FROM rental AS r
JOIN payment AS p
USING (rental_id)
GROUP BY DATE_FORMAT(r.rental_date, '%a')
ORDER BY DATE_FORMAT(r.rental_date, '%a') ASC;


---정답해설) 요일별 GROUPING 미 렌탈 건수와 총금액 

SELECT DATE_FORMAT(r.rental_date, '%a'), COUNT(*), SUM(p.amount)
FROM rental AS r
JOIN payment AS p
USING (rental_id)
GROUP BY WEEKDAY(r.rental_date);

--- 문제 7) 영화의 실제 대여 기간 계산

SELECT r.rental_id, DATEDIFF(r.return_date, r.rental_date) AS 대여기간
FROM rental AS r;


SELECT r.customer_id, c.last_name, DATEDIFF(r.return_date, r.rental_date) AS 대여일
FROM rental AS r
JOIN customer AS c
USING (customer_id);