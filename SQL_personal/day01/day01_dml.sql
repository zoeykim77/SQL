USE lecture;
SHOW TABLES;
DESC user_info;

-- birthdate, date로 설정 안됨 

SELECT *
FROM user_info;

--DML : 데이터 조작 
--[1] INSERT 데이터 삽입 
-- 단일 행 입력 
INSERT INTO user_info(user_id, name, email, birth_date)
VALUES(101, 'alex', 'alex@exmaple','2000.01.01');

--Affectedrow; 영향을 받은 행이다 알림

SELECT *
FROM user_info;

-- 다중행 입력 

INSERT INTO user_info(user_id, name, email, birth_date)
VALUES (102, 'jun', 'jun@exmaple','1900.01.01'),
        (103, 'kim', 'kim@exmaple','1000.01.01');
-- Primary key 첫행과 동일한 값 입력시 중복불가로 뜸 

SELECT *
FROM user_info;

--[2] SELECT : 데이터 조회 
--데이터 가져오거나 필터링하지만, 데이터 자체를 변경하지 않는다. 
--무엇을 선택하고, 어떤걸 볼지, 어떻게 볼건지, 다른 테이블과의 연결, 합치기, 요약은?
--대부분 SQL을 SELECT를 잘 다루는가! 

SELECT user_id, name
FROM user_info
WHERE user_id =102;
-- WHERE 조건문, WHERE name ='jun' 혹은 WHERE user_id > 101 등 

SELECT *
FROM user_info;

--[3] UPDATE : 값 수정하기 
--특정케이스만 업데이트 
UPDATE user_info
SET birth_date = '1988-01-01'
WHERE name = 'jun';

SELECT *
FROM user_info;

--[4] DELETE : 값 삭제하기
--DROP은 구조 삭제 VS DELETE 특정값삭제(테이블유지)
--VS tRUNCATE 모든 행 데이터 삭제. WHERE 조건 못검 모두 삭제! 
--WHERE로 조건 정하고 삭제, 삭제전 주의! DELETE, WHERE 활용! 

DELETE FROM user_info
WHERE user_id = 101;

SELECT *
FROM user_info;