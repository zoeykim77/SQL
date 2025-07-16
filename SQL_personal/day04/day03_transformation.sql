---데이터 형변환 Transformation

---[1] 데이터 타입 체계 : 현재타입을 알아야 올바른 형변환 가능 
--- 보이는 것과 저장된 것의 차이! 
--- 숫자/문자/시간및날짜 
USE world;
SHOW TABLES;
DESC city;

SHOW CREATE TABLE city; --- DDL 전문보기, 상세하게! 

---[2] 암시적 형변환 : MYSQL내에서 자동적, 알아서 변환 
SELECT 1+'1';
-- 2, 숫자+문자열-> 자동 숫자로 연산해줌 ! 
-- 그러나 원하는 형태가 아닐 수도 있다. 문자열 연산(1,1)을 원했을 수도 있으니

---[3] 명시적 형변환 : 원하는 형태로 명확한 반환 원할시
);
--- CAST 함수 
--- expression : 변환하려는 값, 컬럼이름, 표현식 
--- target_data_type : 변환하고자 하는 목표 데이터 타입 
CAST (expression AS target_data_type)

--- 예시 
SELECT CAST(2 AS CHAR);--2라는 값을 문자열로 만들어주는 cast 함수
SELECT CAST(2 AS UNSIGNED);--부호가 없는 정수 0, 양수
SELECT CAST(-2 AS DECIMAL(3,2)); --실수 
SELECT CAST(20250607 AS DATE); -- 날짜

--- 바꿀수 있는 것만 바꾼다. 
--- 파이썬 float 형변환처럼. 


-- 문자-> 숫자로! 
SELECT CAST('123' AS SIGNED) + CAST('77' AS SIGNED);
-- 결과: 200 / 명시적 변환 
SELECT '123'+'77';
---결과: 200 / 암시적 변환 (동일값, 그러나 의도한 바와 다를 수 있기에 명시적)


--- 숫자-> 문자로 ! 
--- CONCAT 함수 (문자열만 연결) + CAST 함수 
SELECT CONCAT(CAST(city.ID AS CHAR), '번')
FROM city
WHERE CountryCode = 'KOR';

--- 그냥 연산은 불가하기에! ID(int) + '번'(CHAR)
SELECT city.ID + '번' 
FROM city
WHERE CountryCode = 'KOR';

--- 문자 -> 날짜 
--- 날짜에 사용가능한 함수 가능 
--- YEAR / MONTH / WEEK 함수 + CAST 함수 
SELECT YEAR(CAST('2025-07-16' AS DATE));
-- 결과: 2025