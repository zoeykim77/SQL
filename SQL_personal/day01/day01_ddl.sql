SHOW DATABASES;

--DDL 
--[1] CREATE 생성 
--(1) lecture 데이터베이스 생성 
CREATE DATABASE lecture;
SHOW DATABASES; --확인 

--(2) 테이블 만들기 
USE lecture; 
--보이진 않지만 lecture로 이동
CREATE TABLE user (user_id INT PRIMARY KEY, name VARCHAR(50), email VARCHAR(100));

SHOW TABLES;

SELECT *
FROM `user`;
-- user 테이블 형식 확인가능 
-- dml 수정시, 형식/제약조건에 안맞으면 삽입 x 

-- [2] Alter : 변경 
-- 컬럼추가 
ALTER TABLE `user`
ADD birth_date DATE NOT NULL;

DESC user;

--컬럼 명, 속성 변경 
ALTER TABLE `user`
MODIFY name VARCHAR(100) NOT NULL;

DESC user;

-- [3] Drop : 삭제 
--DROP DATABASE IF EXISTS database_name;  

CREATE TABLE test(
    id INT PRIMARY KEY,
    name VARCHAR(50));

DESC test;

--문의사항:
--왜 계속 world로 돌아가지? 왜 world 에서 use 생성? lecture로 매번 재지정? 
--> USE lecture 혹은 상단 수동설정가능! 
--테이블생성시 쉼표, 반드시 

--앞서 생성한 test 테이블 삭제 
--되돌릴 수 없다. DROP 동시에 AUTO COMMIT 

DROP TABLE IF EXISTS test; 
SHOW TABLES

-- [4] RENAME : 변경 

RENAME TABLE user
TO user_info;

SHOW TABLES;


USE world;
SHOW TABLES;

DROP TABLE user_info;