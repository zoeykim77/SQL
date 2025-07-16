-- 조건분기 
-- 파이썬 IF, Else 구문 

--- [1] IF : 참,거짓 단순케이스 
--- IF (조건, T일시 반환값, F일시 반환값)
--- 파이썬 IF, ELSE 구문 

SELECT
  Name,
  LifeExpectancy,
  IF(LifeExpectancy >= 70, '장수 국가', '해당 없음') AS '분류'
FROM country
WHERE Continent = 'Asia';

--- [2] CASE : 여러조건 경우
--- 파이선 if-elif-else 구문 
--- CASE WHEN 조건 1 THEN 결과 1
---      WHEN 조건 2 THEN 결과 2 
---      ELSE 기본값 (없을시 NULL 반환) 
--- END (+AS 컬렴명)
--- SELECT 문 OR FROM 문에서 쓰이기도 

USE world;
SELECT c.Name, c.Continent,
        CASE 
            WHEN c.Continent = 'Asia' THEN '아시아권'
            WHEN c.Continent = 'Europe' THEN '유럽권'
            ELSE '기타' ---ELSE 구문 없을시, 그외 케이스는 NULL로 반환됨 
        END AS '권역'--END 후, AS + 컬럼명
FROM country AS c
LIMIT 10;