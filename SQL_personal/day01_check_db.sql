
---SHOW 명령어 : 구성요소 및 상태들 확인 / 목록 확인 
---SHOW 명령어 : 확인한다 & 본다 

---(1) 데이터 베이스 목록확인 
SHOW DATABASES;

--(2) 데이터 베이스 선택 
USE world;

--(3) 데이터 베이스 내 테이블 확인 
SHOW TABLES;

--(+) 테이블 생성시 사용한 코드도 볼 수 있다. 
SHOW CREATE TABLE world.country;

--DESCRIBE 명령어 : 확인 (자세하게 설명)

DESCRIBE country;
DESC world.countrylanguage;
--country 테이블의 각 컬럼의 결측치여부, 코드, Key 여부, 디폴트 확인
--테이블의 각 컬럼 묘사

